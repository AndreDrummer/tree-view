import 'package:tree_view/simple_tree/widgets/tree_builder.dart';
import 'package:tree_view/simple_tree/widgets/tree_scroller.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:get/get.dart' hide Node;
import 'package:flutter/material.dart';
import '../builder/node.dart';

class Tree<T> extends StatelessWidget {
  const Tree(
    this.node, {
    super.key,
    required this.horizontalController,
    required this.breadCrumbLinesColor,
    this.allowHorizontalScrool = true,
    required this.verticalController,
    this.scrollToTheEndOfData = true,
    this.allowVerticalScrool = true,
    required this.elementsColor,
    required this.nodeRowConfig,
    this.toggleNodeView,
  });

  final void Function(Node<NodeData<T>> node)? toggleNodeView;
  final ScrollController horizontalController;
  final ScrollController verticalController;
  final Color breadCrumbLinesColor;
  final bool allowHorizontalScrool;
  final bool scrollToTheEndOfData;
  final bool allowVerticalScrool;
  final Node<NodeData<T>> node;
  final Color elementsColor;

  // Properties related to the row
  final NodeRowConfig Function(T? data) nodeRowConfig;

  int lineBreadCrumbHeight() {
    int descendentsShowing = node.numberOfDescendentsShowingUp;

    return (48 * descendentsShowing);
  }

  double verticalHeight() {
    if (allowVerticalScrool) {
      return Get.height * .725;
    } else {
      return lineBreadCrumbHeight().toDouble() + 50;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TreeScroller(
      viewWidth: (Get.width * (node.getHeightFromNodeToRoot + 1)),
      allowHorizontalScrool: allowHorizontalScrool,
      scrollToTheEndOfData: scrollToTheEndOfData,
      horizontalController: horizontalController,
      allowVerticalScrool: allowVerticalScrool,
      verticalController: verticalController,
      jumpTo: node.getHeight.toDouble(),
      viewHeight: verticalHeight(),
      child: TreeBuilder(
        node,
        allowHorizontalScrool: allowHorizontalScrool,
        breadCrumbLinesColor: breadCrumbLinesColor,
        horizontalController: horizontalController,
        scrollToTheEndOfData: scrollToTheEndOfData,
        allowVerticalScrool: allowVerticalScrool,
        verticalController: verticalController,
        toggleNodeView: toggleNodeView,
        elementsColor: elementsColor,
        nodeRowConfig: nodeRowConfig,
      ),
    );
  }
}
