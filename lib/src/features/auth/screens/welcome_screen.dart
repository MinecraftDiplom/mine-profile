import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mine_profile/src/core/extensions/context_extension.dart';
import 'package:mine_profile/src/core/utils/telegram_page.dart';
import 'package:mine_profile/src/routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var storage = const FlutterSecureStorage();
    FutureBuilder(
      future: storage.read(key: "auth"),
      builder: (context, snapshot) {
        if (snapshot.data == "true") {
          context.go(ScreenRoutes.home.path);
        }
        return Spacer(flex: 0);
      },
    );

    final theme = context.theme;
    return Theme(
      data: theme.copyWith(
        textTheme: GoogleFonts.notoSansMonoTextTheme(theme.textTheme),
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Авторизация в MineProfile",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
                  .animate()
                  .fadeIn()
                  .scale()
                  .move(delay: 300.ms, duration: 600.ms),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () =>
                    openTelegramPage("https://t.me/Koliy82Bot"), // Image tapped
                child: Image.asset(
                  "assets/first_screen.gif",
                  height: 360,
                  width: 360,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    context.go(ScreenRoutes.signIn.path);
                  },
                  child: const Text('Войти')),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => openTelegramPage("https://t.me/Koliy82Bot"),
                child: const ListTile(
                  trailing: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.telegram_outlined, color: Colors.white),
                  ),
                  visualDensity: VisualDensity(vertical: -4),
                  minLeadingWidth: 32,
                  title: Text(
                    "нет minecraft аккаунта?",
                    textAlign: TextAlign.center,
                  ),
                ),
              ).animate().fade(duration: 500.ms).scale(delay: 200.ms),
            ],
          ),
        ),
      ),
    );
  }
}
