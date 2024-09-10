import 'package:tree_view/core/appearence/controller/appearence_controller.dart';
import 'package:tree_view/core/system/initializers.dart';
import 'package:tree_view/features/home/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  SystemInitializer.initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _themeData(bool darkMode) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: darkMode ? Colors.lightBlue : Colors.blue,
      ),
      useMaterial3: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppearenceController appearence = Get.find();

    return GetMaterialApp(
      home: Home(darkMode: appearence.isDarkModeON),
      debugShowCheckedModeBanner: false,
      theme: _themeData(appearence.isDarkModeON),
    );
  }
}
