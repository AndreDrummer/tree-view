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
    this.alwaysScrollToTheEndOfTree = true,
    this.allowVerticalScrool = true,
    this.showBackTopButton = true,
    required this.elementsColor,
    required this.nodeRowConfig,
    this.toggleNodeView,
  });

  final void Function(Node<NodeData<T>> node)? toggleNodeView;
  final ScrollController horizontalController;
  final ScrollController verticalController;
  final Color breadCrumbLinesColor;
  final bool allowHorizontalScrool;
  final bool alwaysScrollToTheEndOfTree;
  final bool allowVerticalScrool;
  final bool showBackTopButton;
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
      alwaysScrollToTheEndOfTree: alwaysScrollToTheEndOfTree,
      horizontalController: horizontalController,
      allowVerticalScrool: allowVerticalScrool,
      verticalController: verticalController,
      showBackTopButton: showBackTopButton,
      nodeHeight: node.getHeight,
      viewHeight: verticalHeight(),
      child: TreeBuilder(
        node,
        allowHorizontalScrool: allowHorizontalScrool,
        breadCrumbLinesColor: breadCrumbLinesColor,
        alwaysScrollToTheEndOfTree: alwaysScrollToTheEndOfTree,
        allowVerticalScrool: allowVerticalScrool,
        horizontalController: ScrollController(),
        verticalController: ScrollController(),
        showBackTopButton: showBackTopButton,
        toggleNodeView: toggleNodeView,
        elementsColor: elementsColor,
        nodeRowConfig: nodeRowConfig,
      ),
    );
  }
}
