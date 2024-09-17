import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const Color secondaryColor = Color(0XFF2188FF);
  static const Color primaryColor = Color(0xFF17192D);
  static const Color dark = Colors.black;
  static const Color light = Colors.white;
  static const Color dark1 = Colors.black12;
  static const Color light1 = Colors.white12;
  static const Color light2 = Colors.white54;

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    onPrimaryContainer: primaryColor,
    brightness: Brightness.dark,
    primary: secondaryColor,
    surface: dark,
  );

  static const ColorScheme _lightColorScheme = ColorScheme.light(
    onPrimaryContainer: secondaryColor,
    brightness: Brightness.light,
    primary: primaryColor,
    surface: light,
  );

  static ThemeData lightMode = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppTheme.secondaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: light,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 18, color: AppTheme.light),
      bodyLarge: TextStyle(fontSize: 20, color: AppTheme.light),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(AppTheme.light),
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(AppTheme.light),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(AppTheme.secondaryColor),
        foregroundColor: const WidgetStatePropertyAll(AppTheme.light),
        iconColor: const WidgetStatePropertyAll(AppTheme.light),
        foregroundBuilder: (context, states, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          );
        },
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(color: AppTheme.light),
        ),
      ),
    ),
    scaffoldBackgroundColor: light,
    colorScheme: _lightColorScheme,
    brightness: Brightness.light,
    useMaterial3: true,
  );

  static ThemeData darkMode = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppTheme.primaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: dark,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 18, color: AppTheme.light),
      bodyLarge: TextStyle(fontSize: 20, color: AppTheme.light),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(AppTheme.light),
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(AppTheme.light),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(AppTheme.primaryColor),
        foregroundColor: const WidgetStatePropertyAll(AppTheme.light),
        iconColor: const WidgetStatePropertyAll(AppTheme.light),
        foregroundBuilder: (context, states, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          );
        },
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(color: AppTheme.light),
        ),
      ),
    ),
    scaffoldBackgroundColor: dark,
    colorScheme: _darkColorScheme,
    brightness: Brightness.dark,
    useMaterial3: true,
  );
}
