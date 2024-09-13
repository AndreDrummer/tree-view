import 'package:tree_view/simple_tree/builder/tree_manager.dart';
import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/widgets/tree_widget.dart';
import 'package:flutter/material.dart';

class WidgetTree<T> extends StatelessWidget {
  const WidgetTree({
    super.key,
    required this.horizontalScrollController,
    required this.verticalScrollController,
    this.showCustomizationForRoot = true,
    required this.breadCrumbLinesColor,
    this.backTopButtonBackgroundColor,
    this.initializeExpanded = true,
    this.showBackTopButton = true,
    this.backTopButtonIconColor,
    required this.elementsColor,
    this.resetOnFilter = true,
    required this.nodeConfig,
    required this.treeManager,
    this.filterPredicate,
    this.backgroundColor,
  });

  final bool Function(ParentProtocol)? filterPredicate;
  final bool showCustomizationForRoot;
  final bool initializeExpanded;
  final TreeManager treeManager;
  final bool showBackTopButton;
  final bool resetOnFilter;

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
      treeManager: treeManager,
      nodeConfig: nodeConfig,
    );
  }
}
