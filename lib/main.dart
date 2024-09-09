import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/features/assets/widgets/data_view.dart';
import 'package:tree_view/core/models/person.dart';
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
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeController, _) {
        final bool darkMode = homeController.isDarkModeON;
        final Color breadCrumbLinesColor =
            darkMode ? Colors.white12 : Colors.black12;
        final Color elementsColor = darkMode ? Colors.white : Colors.black;

        return Consumer<AssetsController>(
          builder: (context, controller, _) {
            return DataView<Person>(
              dataList: controller.data,
              nodeRowTitle: (Person data) {
                return data.name;
              },
              backgroundColor: darkMode ? Colors.black : Colors.white,
              breadCrumbLinesColor: breadCrumbLinesColor,
              elementsColor: elementsColor,
            );
          },
        );
      },
    );
  }
}
