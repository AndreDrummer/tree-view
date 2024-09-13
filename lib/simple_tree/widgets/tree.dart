import 'package:tree_view/simple_tree/widgets/tree_builder.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:flutter/material.dart';
import '../builder/node.dart';

class Tree<T> extends StatelessWidget {
  const Tree(
    this.node, {
    super.key,
    required this.showCustomizationForRoot,
    required this.horizontalController,
    required this.breadCrumbLinesColor,
    this.backTopButtonBackgroundColor,
    this.allowHorizontalScrool = true,
    required this.verticalController,
    this.allowVerticalScrool = true,
    this.showBackTopButton = true,
    required this.elementsColor,
    this.backTopButtonIconColor,
    required this.nodeRowConfig,
    required this.nodeRootId,
    this.toggleNodeView,
  });

  final void Function(Node<NodeData<T>> node)? toggleNodeView;
  final ScrollController horizontalController;
  final Color? backTopButtonBackgroundColor;
  final ScrollController verticalController;
  final Color? backTopButtonIconColor;
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

  @override
  Widget build(BuildContext context) {
    return TreeBuilder(
      node,
      backTopButtonBackgroundColor: backTopButtonBackgroundColor,
      showCustomizationForRoot: showCustomizationForRoot,
      backTopButtonIconColor: backTopButtonIconColor,
      allowHorizontalScrool: allowHorizontalScrool,
      breadCrumbLinesColor: breadCrumbLinesColor,
      horizontalController: horizontalController,
      allowVerticalScrool: allowVerticalScrool,
      verticalController: verticalController,
      showBackTopButton: showBackTopButton,
      toggleNodeView: toggleNodeView,
      elementsColor: elementsColor,
      nodeRowConfig: nodeRowConfig,
      nodeRootId: nodeRootId,
    );
  }
}
