import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:mine_profile/src/features/auth/screens/code_verification_screen.dart';
import 'package:mine_profile/src/features/auth/screens/welcome_screen.dart';
import 'package:mine_profile/src/features/home/screens/home_screen.dart';

import 'features/auth/screens/sign_in_screen.dart';

/// [ScreenRoutes] class defines static getters to retrieve instances
/// of the [ScreenRoute].
/// Each method returns a unique route with
/// a specified 'name' and 'path'.
abstract final class ScreenRoutes {
  ///[WelcomeScreen] route
  static ScreenRoute get welcome => ScreenRoute(
        name: 'welcome',
        path: '/welcome',
        goPath: '/welcome',
      );

  ///[SignInScreen] route
  static ScreenRoute get signIn => ScreenRoute(
        name: 'signIn',
        path: '/welcome/signIn',
        goPath: 'signIn',
      );

  ///[CodeVerificationScreen] route
  static ScreenRoute get verify => ScreenRoute(
        name: 'verify',
        path: '/welcome/signIn/verify',
        goPath: 'verify/:code',
      );

  ///[HomeScreen] route
  static ScreenRoute get home => ScreenRoute(
        name: 'home',
        path: '/home',
        goPath: '/home',
      );

  static GoRouter get router => _router;

  static const storage = FlutterSecureStorage();

  static final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: ScreenRoutes.welcome.path,
    routes: [
      GoRoute(
        name: ScreenRoutes.home.name,
        path: ScreenRoutes.home.goPath,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
          name: ScreenRoutes.welcome.name,
          path: ScreenRoutes.welcome.goPath,
          builder: (context, state) => const WelcomeScreen(),
          redirect: (context, state) async {
            if (await storage.read(key: "auth") == "true")
              return ScreenRoutes.home.path;
            return null;
          },
          routes: [
            GoRoute(
                name: ScreenRoutes.signIn.name,
                path: ScreenRoutes.signIn.goPath,
                builder: (context, state) => const SignInScreen(),
                routes: [
                  GoRoute(
                    name: ScreenRoutes.verify.name,
                    path: ScreenRoutes.verify.goPath,
                    builder: (context, state) {
                      final code = state.pathParameters['code']!;
                      return CodeVerificationScreen(code: code);
                    },
                  ),
                ]),
          ]),
    ],
  );
}

/// The [ScreenRoute] class represents a model
/// for defining routes in the application.
final class ScreenRoute {
  ///Constructor
  ScreenRoute({
    required this.name,
    required this.path,
    required this.goPath,
  });

  ///Route name
  final String name;

  ///Route path
  final String path;

  ///Path in [GoRoute] path
  final String goPath;
}
