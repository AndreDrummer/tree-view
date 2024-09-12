import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';
import 'package:tree_view/core/constants/graphic_assets.dart';
import 'package:tree_view/core/models/data_item.dart';
import 'package:tree_view/core/models/enums.dart';
import 'package:tree_view/core/widgets/dark_mode_button.dart';
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
    );
  }

  Widget tree() {
    final AssetsController assetsController = Get.find();

    bool predicate(data) => assetsController.filterPredicate(data);

    return WidgetTree<DataItem>(
      rootData: assetsController.rootData,
      dataList: assetsController.data,
      elementsColor: Get.isDarkMode ? AppTheme.light : AppTheme.primaryColor,
      backTopButtonBackgroundColor:
          Get.isDarkMode ? AppTheme.secondaryColor : AppTheme.primaryColor,
      breadCrumbLinesColor: Get.isDarkMode ? AppTheme.light1 : AppTheme.dark1,
      nodeConfig: (DataItem data) => nodeRow(data, Get.isDarkMode),
      horizontalScrollController: horizontalScrollController,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      verticalScrollController: verticalScrollController,
      backTopButtonIconColor: AppTheme.light,
      alwaysScrollToTheEndOfTree: false,
      filterPredicate: predicate,
      initializeExpanded: true,
      showBackTopButton: true,
    );
  }

  String prefixIconBasedOnKind(ItemKind kind) {
    switch (kind) {
      case ItemKind.location:
        return SVGAssets.location.name;
      case ItemKind.asset:
        return SVGAssets.asset.name;
      case ItemKind.component:
        return SVGAssets.component.name;
    }
  }

  NodeRowConfig nodeRow(DataItem item, bool darkMode) {
    final prefixIcon = prefixIconBasedOnKind(item.kind);
    final Color prefixIconColor =
        darkMode ? AppTheme.light : AppTheme.secondaryColor;

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
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Assets",
          style: TextStyle(color: AppTheme.light),
        ),
        actions: const [DarkModeButton()],
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            searchHeader(),
            tree(),
          ],
        );
      }),
    );
  }
}
