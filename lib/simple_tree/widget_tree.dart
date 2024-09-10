import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/widgets/tree_widget.dart';
import 'package:flutter/material.dart';

class WidgetTree<T> extends StatelessWidget {
  const WidgetTree({
    super.key,
    required this.horizontalScrollController,
    required this.verticalScrollController,
    required this.breadCrumbLinesColor,
    required this.elementsColor,
    this.resetOnFilter = true,
    required this.nodeConfig,
    required this.dataList,
    this.filterPredicate,
    this.backgroundColor,
  });

  final bool Function(Parent)? filterPredicate;
  final List<Parent> dataList;
  final bool resetOnFilter;

  final ScrollController horizontalScrollController;
  final ScrollController verticalScrollController;

  final Color breadCrumbLinesColor;
  final Color? backgroundColor;
  final Color elementsColor;

  // Properties related to the row
  final NodeRowConfig Function(T data) nodeConfig;

  @override
  Widget build(BuildContext context) {
    return TreeWidget(
      horizontalScrollController: horizontalScrollController,
      verticalScrollController: verticalScrollController,
      breadCrumbLinesColor: breadCrumbLinesColor,
      filterPredicate: filterPredicate,
      backgroundColor: backgroundColor,
      resetOnFilter: resetOnFilter,
      elementsColor: elementsColor,
      nodeConfig: nodeConfig,
      dataList: dataList,
    );
  }
}
