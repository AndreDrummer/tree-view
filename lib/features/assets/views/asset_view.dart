import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_view/core/models/person.dart';
import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/assets/widgets/search_header.dart';
import 'package:tree_view/core/appearence/controller/appearence_controller.dart';
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

  Widget searchHeader() {
    final AppearenceController appearence = Get.find();
    final AssetsController controller = Get.find();

    final isFilteringByFemale = controller.isFilteringByFemale;
    final isFilteringByMale = controller.isFilteringByMale;

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
      darkMode: appearence.isDarkModeON,
    );
  }

  Widget tree() {
    final AssetsController assetsController = Get.find();
    final AppearenceController appearence = Get.find();
    final bool darkMode = appearence.isDarkModeON;

    bool predicate(data) => assetsController.filterPredicate(data);

    return WidgetTree<Person>(
      dataList: assetsController.data,
      breadCrumbLinesColor: darkMode ? Colors.white12 : Colors.black12,
      backgroundColor: darkMode ? Colors.black : Colors.white,
      elementsColor: darkMode ? Colors.white : Colors.black,
      horizontalScrollController: horizontalScrollController,
      nodeConfig: (Person data) => nodeRow(data, darkMode),
      verticalScrollController: verticalScrollController,
      alwaysScrollToTheEndOfTree: false,
      filterPredicate: predicate,
      initializeExpanded: true,
      showBackTopButton: true,
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
    return Obx(() {
      return Column(
        children: [
          searchHeader(),
          tree(),
        ],
      );
    });
  }
}
