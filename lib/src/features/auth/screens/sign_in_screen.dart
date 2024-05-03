import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mine_profile/src/core/extensions/context_extension.dart';
import 'package:mine_profile/src/core/utils/telegram_page.dart';
import 'package:mine_profile/src/features/auth/models/user_data_entity.dart';
import 'package:mine_profile/src/routes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController usernameController;
  String _message = '';

  void _login() async {
    try {
      final dio = Dio();

      final response = await dio.get(
        'http://kissota.ru:9000/auth/code/${usernameController.text}',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            _message = switch (status) {
              200 => '',
              400 => '',
              404 =>
                'Не удалось найти такое имя пользователя, возможно вы не зарегистрировались в боте или ввели неправильный telegram username.',
              500 =>
                'Ошибка при отправке сообщения со стороны сервера. Возможно вы не нажали /start в боте (Нажмите по тексту сверху).',
              _ => 'Неизвестная ошибка'
            };
            setState(() {});
            return true;
          },
        ),
      );

      if (response.statusCode == 200) {
        var data = UserData.fromJson(response.data);
        const storage = FlutterSecureStorage();
        await storage.write(key: "user_data", value: UserData.serialize(data));
        context.go("${ScreenRoutes.verify.path}/${response.data["code"]}");
      }
    } on Exception catch (_, e) {}
  }

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Theme(
      data: theme.copyWith(
        textTheme: GoogleFonts.notoSansMonoTextTheme(theme.textTheme),
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () =>
                    openTelegramPage("https://t.me/MineProfileCodeBot"),
                child: const ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  minLeadingWidth: 32,
                  leading: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.telegram_outlined, color: Colors.white),
                  ),
                  title: Text(
                    "Нажмите /start в боте",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // GestureDetector(
              //   onTap: () => openTelegramPage("https://t.me/MineProfileCodeBot"),
              //   child: Image.asset(
              //     "assets/first_screen.gif",
              //     height: 400,
              //     width: 400,
              //   ),
              // ),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                    labelText: 'Введите свой telegram username'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: Text('Отправить код')),
              const SizedBox(height: 20),
              Text(_message),
            ],
          ),
        ),
      ),
    );
  }
}
