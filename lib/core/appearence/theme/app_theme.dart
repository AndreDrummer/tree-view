import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static Color dark1 = const Color.fromARGB(255, 8, 3, 3);
  static const Color secondaryColor = Color(0XFF2188FF);
  static const Color primaryColor = Color(0xFF17192D);
  static const Color light1 = Colors.white;

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    brightness: Brightness.dark,
    primary: primaryColor,
    surface: primaryColor,
  );

  static const ColorScheme _lightColorScheme = ColorScheme.light(
    onPrimaryContainer: secondaryColor,
    brightness: Brightness.light,
    primary: secondaryColor,
    surface: secondaryColor,
  );

  static ThemeData light = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppTheme.secondaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: light1,
      ),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(AppTheme.light1),
      ),
    ),
    scaffoldBackgroundColor: light1,
    colorScheme: _lightColorScheme,
    brightness: Brightness.light,
    useMaterial3: true,
  );

  static ThemeData dark = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppTheme.primaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: dark1,
      ),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(AppTheme.light1),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(backgroundColor: dark1),
    scaffoldBackgroundColor: dark1,
    colorScheme: _darkColorScheme,
    brightness: Brightness.dark,
    useMaterial3: true,
  );

  static Color getAccentVariant(Color color) {
    // Convert the color to HSL to manipulate lightness
    HSLColor hsl = HSLColor.fromColor(color);

    // Create an accent variant by increasing lightness and/or saturation
    HSLColor accentHSL =
        hsl.withLightness((hsl.lightness + 0.3).clamp(0.0, 1.0));
    // hsl.withSaturation((hsl.lightness + 0.3).clamp(0.0, 1.0));

    // Convert back to Color
    return accentHSL.toColor();
  }
}
