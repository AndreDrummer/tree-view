import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/widgets/tree_widget.dart';
import 'package:flutter/material.dart';

class WidgetTree<T> extends StatelessWidget {
  const WidgetTree({
    super.key,
    required this.horizontalScrollController,
    this.alwaysScrollToTheEndOfTree = true,
    required this.verticalScrollController,
    required this.showCustomizationForRoot,
    required this.breadCrumbLinesColor,
    this.backTopButtonBackgroundColor,
    this.initializeExpanded = true,
    this.showBackTopButton = true,
    this.backTopButtonIconColor,
    required this.elementsColor,
    this.resetOnFilter = true,
    required this.nodeConfig,
    required this.rootData,
    required this.dataList,
    this.filterPredicate,
    this.backgroundColor,
  });

  final bool Function(Parent)? filterPredicate;
  final bool alwaysScrollToTheEndOfTree;
  final bool showCustomizationForRoot;
  final bool initializeExpanded;
  final bool showBackTopButton;
  final List<Parent> dataList;
  final bool resetOnFilter;
  final Parent rootData;

  final ScrollController horizontalScrollController;
  final ScrollController verticalScrollController;

  final Color? backTopButtonBackgroundColor;
  final Color? backTopButtonIconColor;

  final Color breadCrumbLinesColor;
  final Color? backgroundColor;
  final Color elementsColor;

  // Properties related to the row
  final NodeRowConfig Function(T data) nodeConfig;

  @override
  Widget build(BuildContext context) {
    return TreeWidget(
      backTopButtonBackgroundColor: backTopButtonBackgroundColor,
      alwaysScrollToTheEndOfTree: alwaysScrollToTheEndOfTree,
      horizontalScrollController: horizontalScrollController,
      showCustomizationForRoot: showCustomizationForRoot,
      verticalScrollController: verticalScrollController,
      backTopButtonIconColor: backTopButtonIconColor,
      breadCrumbLinesColor: breadCrumbLinesColor,
      initializeExpanded: initializeExpanded,
      showBackTopButton: showBackTopButton,
      filterPredicate: filterPredicate,
      backgroundColor: backgroundColor,
      resetOnFilter: resetOnFilter,
      elementsColor: elementsColor,
      nodeConfig: nodeConfig,
      rootData: rootData,
      dataList: dataList,
    );
  }
}
