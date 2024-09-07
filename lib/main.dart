import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/features/assets/widgets/data_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => AssetsController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        final bool darkModeIsON = controller.isDarkModeON;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: darkModeIsON ? Colors.lightBlueAccent : Colors.blue,
            ),
            useMaterial3: true,
          ),
          home: MyHomePage(
            controller: controller,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final bool darkModeIsON = controller.isDarkModeON;
    final backgroundColor = darkModeIsON ? Colors.black : Colors.white;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 8,
          title: Text(
            "TreeView - App",
            style: TextStyle(
              color: darkModeIsON ? Colors.white : Colors.black,
              fontSize: 18,
            ),
          ),
          backgroundColor: backgroundColor,
          actions: [
            IconButton(
              onPressed: controller.toggleAppearenceMode,
              icon: Icon(
                darkModeIsON ? Icons.light_mode : Icons.dark_mode,
                color: darkModeIsON ? Colors.white : Colors.black,
              ),
            )
          ],
        ),
        body: DataView(darkModeIsON: controller.isDarkModeON),
      ),
    );
  }
}
