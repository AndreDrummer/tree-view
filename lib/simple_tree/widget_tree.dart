import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/widgets/tree_widget.dart';
import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';
import 'package:flutter/material.dart';

class WidgetTree<T> extends StatelessWidget {
  const WidgetTree({
    super.key,
    this.alwaysScrollToTheEndOfData = true,
    required this.breadCrumbLinesColor,
    required this.elementsColor,
    required this.nodeConfig,
    required this.dataList,
    this.backgroundColor,
    this.backToTopButton,
  });

  final List<Parent> dataList;

  final bool alwaysScrollToTheEndOfData;
  final Color breadCrumbLinesColor;
  final Widget? backToTopButton;
  final Color? backgroundColor;
  final Color elementsColor;

  // Properties related to the row
  final NodeRowConfig Function(T data) nodeConfig;

  @override
  Widget build(BuildContext context) {
    return TreeWidget(
      alwaysScrollToTheEndOfData: alwaysScrollToTheEndOfData,
      breadCrumbLinesColor: breadCrumbLinesColor,
      backToTopButton: backToTopButton,
      backgroundColor: backgroundColor,
      elementsColor: elementsColor,
      nodeConfig: nodeConfig,
      dataList: dataList,
    );
  }
}
