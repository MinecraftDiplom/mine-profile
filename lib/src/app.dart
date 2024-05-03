import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mine_profile/src/core/extensions/context_extension.dart';
import 'package:mine_profile/src/routes.dart';
import 'package:provider/provider.dart';

import 'common/theme/app_theme.dart';
import 'common/theme/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;
        var seedColor = Colors.lightBlue.shade200;

        lightColorScheme = ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        );

        darkColorScheme = ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        );

        lightColorScheme = lightColorScheme.harmonized();
        darkColorScheme = darkColorScheme.harmonized();

        return ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          child: Consumer<ThemeProvider>(
            builder: (
              BuildContext context,
              ThemeProvider value,
              Widget? child,
            ) {
              final theme = context.theme;
              const labelColor = Color(0xFF8b8b8b);

              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                // scrollBehavior: ScrollWithoutSplash(),
                routerConfig: ScreenRoutes.router,
                themeMode: value.themeMode,
                theme: ThemeData(
                  colorScheme: lightColorScheme,
                  iconTheme: AppTheme.iconThemeData,
                  textTheme: GoogleFonts.notoSansTextTheme().copyWith(
                    headlineLarge: GoogleFonts.inconsolata(),
                    headlineMedium: GoogleFonts.inconsolata(),
                    headlineSmall: GoogleFonts.inconsolata(),
                  ),
                  textButtonTheme: AppTheme.textButtonThemeData,
                  outlinedButtonTheme: AppTheme.outlinedButtonThemeData,
                  filledButtonTheme: AppTheme.filledButtonThemeData,
                  elevatedButtonTheme: AppTheme.elevatedButtonThemeData,
                ),
                darkTheme: ThemeData(
                  colorScheme: darkColorScheme,
                  textTheme: GoogleFonts.notoSansTextTheme().copyWith(
                    headlineSmall: GoogleFonts.inconsolata().copyWith(),
                    bodyLarge: GoogleFonts.notoSans().copyWith(),
                    bodyMedium: GoogleFonts.notoSans().copyWith(),
                    bodySmall: GoogleFonts.notoSans().copyWith(),
                    labelLarge: GoogleFonts.notoSans().copyWith(
                      color: labelColor,
                    ),
                    labelMedium: GoogleFonts.notoSans().copyWith(
                      color: labelColor,
                    ),
                    labelSmall: GoogleFonts.notoSans().copyWith(
                      color: labelColor,
                    ),
                  ),
                  iconTheme: AppTheme.iconThemeData.copyWith(
                    color: theme.colorScheme.surface,
                  ),
                  textButtonTheme: AppTheme.textButtonThemeData,
                  outlinedButtonTheme: AppTheme.outlinedButtonThemeData,
                  filledButtonTheme: AppTheme.filledButtonThemeData,
                  elevatedButtonTheme: AppTheme.elevatedButtonThemeData,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
