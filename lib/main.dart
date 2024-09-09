import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/shared/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/core/models/person.dart';
import 'package:tree_view/shared/tree_widget.dart';
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
              seedColor: darkModeIsON ? Colors.lightBlue : Colors.blue,
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

        return Consumer<AssetsController>(
          builder: (context, controller, _) {
            return TreeWidget<Person>(
              dataList: controller.data,
              nodeConfig: (Person data) {
                return nodeRow(data, darkMode);
              },
              breadCrumbLinesColor: darkMode ? Colors.white12 : Colors.black12,
              backgroundColor: darkMode ? Colors.black : Colors.white,
              elementsColor: darkMode ? Colors.white : Colors.black,
            );
          },
        );
      },
    );
  }

  NodeRowConfig nodeRow(Person person, bool darkMode) {
    final prefixIcon = person.male ? Icons.man : Icons.woman;
    final Color prefixIconColor = darkMode ? Colors.white : Colors.black;

    final suffixIcon =
        person.fat ? Icons.fastfood_outlined : Icons.flash_on_rounded;
    final Color suffixIconColor =
        person.fat ? Colors.redAccent : Colors.greenAccent;

    return NodeRowConfig(
      prefixIconColor: prefixIconColor,
      suffixIconColor: suffixIconColor,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      title: person.name,
      suffixIconSize: 14,
    );
  }
}
