import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/features/assets/widgets/search_header.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/core/widgets/custom_scroll_bar.dart';
import 'package:tree_view/core/widgets/custom_app_bar.dart';
import 'package:tree_view/simple_tree/widget_tree.dart';
import 'package:tree_view/core/models/person.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ScrollController horizontalScrollController;
  late final ScrollController verticalScrollController;

  @override
  void initState() {
    horizontalScrollController = ScrollController();
    verticalScrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    horizontalScrollController.dispose();
    verticalScrollController.dispose();

    super.dispose();
  }

  Widget treeWidget(
    List<Person> seedData,
    bool darkMode, {
    required bool Function(Person) filterPredicate,
  }) {
    bool predicate(data) => filterPredicate(data);

    return WidgetTree<Person>(
      dataList: seedData,
      nodeConfig: (Person data) {
        return nodeRow(data, darkMode);
      },
      breadCrumbLinesColor: darkMode ? Colors.white12 : Colors.black12,
      backgroundColor: darkMode ? Colors.black : Colors.white,
      elementsColor: darkMode ? Colors.white : Colors.black,
      horizontalScrollController: horizontalScrollController,
      verticalScrollController: verticalScrollController,
      filterPredicate: predicate,
      initializeExpanded: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeController, _) {
        final bool darkMode = homeController.isDarkModeON;

        return SafeArea(
          child: Scaffold(
            backgroundColor: darkMode ? Colors.black : Colors.white,
            body: Consumer<AssetsController>(
              builder: (context, controller, _) {
                final isFilteringByFemale =
                    controller.genderTypeFilter == controller.female;

                final isFilteringByMale =
                    controller.genderTypeFilter == controller.male;

                return CustomScrollBar(
                  fixedWidget: const CustomAppBar(),
                  scrollables: [
                    SearchHeader(
                      textInitialValue: controller.textToSearch,
                      isFilteringByFemale: isFilteringByFemale,
                      onFilterByText: controller.setSearchText,
                      isFilteringByMale: isFilteringByMale,
                      onFilterByMale: () {
                        controller.filterByMaleGender();
                      },
                      onFilterByFemale: () {
                        controller.filterByFemaleGender();
                      },
                      darkMode: darkMode,
                    ),
                    treeWidget(
                      filterPredicate: controller.filterPredicate,
                      controller.data,
                      darkMode,
                    ),
                  ],
                );
              },
            ),
          ),
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
