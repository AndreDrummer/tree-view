import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/features/home/views/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AssetsController()),
        ChangeNotifierProvider(create: (context) => HomeController()),
      ],
      child: const MyApp(),
    ),
  );
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
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        final bool darkModeIsON = controller.isDarkModeON;

        return MaterialApp(
          home: Home(darkMode: darkModeIsON),
          debugShowCheckedModeBanner: false,
          theme: _themeData(darkModeIsON),
        );
      },
    );
  }
}
