import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mine_profile/src/features/auth/models/user_data_entity.dart';
import 'package:mine_profile/src/features/home/widgets/rive/rive_icon.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key, required this.data});
  final UserData data;

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  var dio = Dio();
  final _formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  var _isObscured = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLength: 64,
              keyboardType: TextInputType.visiblePassword,
              focusNode: passwordFocusNode,
              obscureText: _isObscured,
              controller: passwordController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: _isObscured
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
                hintText: "New Password",
                icon: const RiveIcon(RiveIcons.lock),
                label: const Text('Minecraft Password'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  passwordFocusNode.requestFocus();
                  return "Заполните поле";
                }
                if (value.length < 6) {
                  passwordFocusNode.requestFocus();
                  return "Длина пароля от 6 символов";
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                var response = await dio.post(
                  "http://kissota.ru:9000/profiles/password/${widget.data.profile!.id}",
                  data: FormData.fromMap(
                    {
                      "password": passwordController.text,
                    },
                  ),
                );
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Пароль успешно изменён')),
                  );
                }
                setState(() {});
              }
            },
            child: const Text('Сменить пароль'),
          ),
        ],
      ),
    );
  }
}
