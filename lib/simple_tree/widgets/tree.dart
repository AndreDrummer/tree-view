import 'package:tree_view/simple_tree/widgets/tree_scroller.dart';
import 'package:tree_view/simple_tree/widgets/tree_builder.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:flutter/material.dart';
import '../builder/node.dart';

class Tree<T> extends StatelessWidget {
  const Tree(
    this.node, {
    super.key,
    this.alwaysScrollToTheEndOfTree = true,
    required this.showCustomizationForRoot,
    required this.horizontalController,
    required this.breadCrumbLinesColor,
    this.allowHorizontalScrool = true,
    required this.verticalController,
    this.allowVerticalScrool = true,
    this.showBackTopButton = true,
    required this.elementsColor,
    required this.nodeRowConfig,
    required this.nodeRootId,
    this.toggleNodeView,
  });

  final void Function(Node<NodeData<T>> node)? toggleNodeView;
  final ScrollController horizontalController;
  final ScrollController verticalController;
  final bool alwaysScrollToTheEndOfTree;
  final bool showCustomizationForRoot;
  final Color breadCrumbLinesColor;
  final bool allowHorizontalScrool;
  final bool allowVerticalScrool;
  final bool showBackTopButton;
  final Node<NodeData<T>> node;
  final Color elementsColor;
  final int nodeRootId;

  // Properties related to the row
  final NodeRowConfig Function(T? data) nodeRowConfig;

  int lineBreadCrumbHeight() {
    int descendentsShowing = node.numberOfDescendentsShowingUp;

    return (48 * descendentsShowing);
  }

  double verticalHeight(double height) {
    if (allowVerticalScrool) {
      return height * .725;
    } else {
      return lineBreadCrumbHeight().toDouble() + 50;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return TreeScroller(
      viewWidth: (width * (node.getHeightFromNodeToRoot + 1)),
      alwaysScrollToTheEndOfTree: alwaysScrollToTheEndOfTree,
      nodeDecendants: node.numberOfDescendentsShowingUp,
      allowHorizontalScrool: allowHorizontalScrool,
      horizontalController: horizontalController,
      allowVerticalScrool: allowVerticalScrool,
      verticalController: verticalController,
      showBackTopButton: showBackTopButton,
      viewHeight: verticalHeight(height),
      nodeHeight: node.getHeight,
      child: TreeBuilder(
        node,
        alwaysScrollToTheEndOfTree: alwaysScrollToTheEndOfTree,
        showCustomizationForRoot: showCustomizationForRoot,
        allowHorizontalScrool: allowHorizontalScrool,
        breadCrumbLinesColor: breadCrumbLinesColor,
        allowVerticalScrool: allowVerticalScrool,
        horizontalController: ScrollController(),
        verticalController: ScrollController(),
        showBackTopButton: showBackTopButton,
        toggleNodeView: toggleNodeView,
        elementsColor: elementsColor,
        nodeRowConfig: nodeRowConfig,
        nodeRootId: nodeRootId,
      ),
    );
  }
}
