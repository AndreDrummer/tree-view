import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tree_view/core/models/person.dart';
import 'package:tree_view/core/widgets/custom_app_bar.dart';
import 'package:tree_view/core/widgets/custom_scroll_bar.dart';
import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/assets/widgets/search_header.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/widget_tree.dart';

class AssetsView extends StatefulWidget {
  const AssetsView({super.key});

  @override
  State<AssetsView> createState() => _AssetsViewState();
}

class _AssetsViewState extends State<AssetsView> {
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

  Widget searchHeader(AssetsController controller, bool darkMode) {
    final isFilteringByFemale =
        controller.genderTypeFilter == controller.female;

    final isFilteringByMale = controller.genderTypeFilter == controller.male;

    return SearchHeader(
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
    );
  }

  Widget tree(
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

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeController, _) {
        final bool darkMode = homeController.isDarkModeON;

        return Consumer<AssetsController>(
          builder: (context, assetsController, _) {
            return CustomScrollBar(
              fixedWidget: const CustomAppBar(),
              scrollables: [
                searchHeader(assetsController, darkMode),
                tree(
                  filterPredicate: assetsController.filterPredicate,
                  assetsController.data,
                  darkMode,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
