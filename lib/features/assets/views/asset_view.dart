import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';
import 'package:tree_view/core/models/coisa.dart';
import 'package:tree_view/core/models/enums.dart';
import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/assets/widgets/search_header.dart';
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
    final AssetsController controller = Get.find();

    final isFilteringByVibration = controller.isFilteringByVibration;
    final isFilteringByEnergy = controller.isFilteringByEnergy;

    return SearchHeader(
      isFilteringByVibration: isFilteringByVibration,
      textInitialValue: controller.textToSearch,
      isFilteringByEnergy: isFilteringByEnergy,
      onFilterByText: controller.setSearchText,
      onFilterByVibration: () {
        controller.filterByVibration();
      },
      onFilterByEnergy: () {
        controller.filterByEnergy();
      },
      darkMode: Get.isDarkMode,
    );
  }

  Widget tree() {
    final AssetsController assetsController = Get.find();

    bool predicate(data) => assetsController.filterPredicate(data);

    return WidgetTree<Coisa>(
      dataList: assetsController.data,
      rootData: Coisa(
        kind: ItemKind.location,
        name: "ROOT",
        id: "998877",
      ),
      breadCrumbLinesColor: Get.isDarkMode ? Colors.white12 : Colors.black12,
      backgroundColor: Get.isDarkMode ? AppTheme.dark1 : AppTheme.light1,
      elementsColor: Get.isDarkMode ? AppTheme.light1 : AppTheme.dark1,
      nodeConfig: (Coisa data) => nodeRow(data, Get.isDarkMode),
      horizontalScrollController: horizontalScrollController,
      verticalScrollController: verticalScrollController,
      alwaysScrollToTheEndOfTree: false,
      showCustomizationForRoot: false,
      filterPredicate: predicate,
      initializeExpanded: true,
      showBackTopButton: true,
    );
  }

  IconData prefixIconBasedOnKind(ItemKind kind) {
    switch (kind) {
      case ItemKind.location:
        return Icons.pin_drop_outlined;
      case ItemKind.asset:
        return Icons.square;
      case ItemKind.component:
        return Icons.grid_on_outlined;
    }
  }

  NodeRowConfig nodeRow(Coisa item, bool darkMode) {
    final prefixIcon = prefixIconBasedOnKind(item.kind);
    final Color prefixIconColor = darkMode ? AppTheme.light1 : AppTheme.dark1;

    final suffixIcon = item.sensorType != null
        ? (item.sensorType == AssetFilter.vibration.name
            ? Icons.circle
            : Icons.flash_on_rounded)
        : null;

    final Color? suffixIconColor = item.sensorType != null
        ? (item.sensorType == AssetFilter.vibration.name
            ? Colors.redAccent
            : Colors.greenAccent)
        : null;

    return NodeRowConfig(
      prefixIconColor: prefixIconColor,
      suffixIconColor: suffixIconColor,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      title: item.name,
      suffixIconSize: item.sensorType != null &&
              item.sensorType == AssetFilter.vibration.name
          ? 8
          : 14,
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
