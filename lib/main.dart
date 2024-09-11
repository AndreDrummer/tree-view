import 'package:tree_view/core/appearence/controller/appearence_controller.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';
import 'package:tree_view/core/system/initializers.dart';
import 'package:tree_view/core/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  SystemInitializer.initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AppearenceController>().setSystemThemeMode();

    return GetMaterialApp(
      onGenerateRoute: RouterGenerator.onGenerateRoute,
      themeMode: Get.find<AppearenceController>().isDarkModeON
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
