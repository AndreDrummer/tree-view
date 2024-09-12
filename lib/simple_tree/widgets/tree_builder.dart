import 'package:tree_view/simple_tree/widgets/line_bread_crumb.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/widgets/node_row.dart';
import 'package:flutter/material.dart';
import '../builder/node.dart';

class TreeBuilder<T> extends StatelessWidget {
  const TreeBuilder(
    this.node, {
    super.key,
    this.toggleNodeView,
    required this.alwaysScrollToTheEndOfTree,
    required this.showCustomizationForRoot,
    required this.breadCrumbLinesColor,
    required this.horizontalController,
    required this.allowHorizontalScrool,
    required this.allowVerticalScrool,
    required this.verticalController,
    required this.showBackTopButton,
    required this.nodeRowConfig,
    required this.elementsColor,
    required this.nodeRootId,
  });

  final void Function(Node<NodeData<T>> node)? toggleNodeView;
  final ScrollController horizontalController;
  final ScrollController verticalController;
  final bool alwaysScrollToTheEndOfTree;
  final bool showCustomizationForRoot;
  final Color breadCrumbLinesColor;
  final bool allowHorizontalScrool;
  final bool allowVerticalScrool;
  final Node<NodeData<T>> node;
  final bool showBackTopButton;
  final Color elementsColor;
  final int nodeRootId;

  // Properties related to the row
  final NodeRowConfig Function(T? data) nodeRowConfig;

  int lineBreadCrumbHeight(Node<NodeData<T>> node) {
    int descendentsShowing = node.numberOfDescendentsShowingUp;

    return (48 * descendentsShowing);
  }

  bool showCustomization() {
    if (node.id == nodeRootId) {
      return showCustomizationForRoot;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1000,
      height: 1000,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NodeRow(
            node,
            showCustomizationForRoot: showCustomization(),
            onPressed: () => toggleNodeView?.call(node),
            breadCrumbLineColor: breadCrumbLinesColor,
            elementsColor: elementsColor,
            nodeRowConfig: nodeRowConfig,
          ),
          Visibility(
            visible: node.expanded,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LineBreadCrumb(
                  lineBreadCrumbHeight(node),
                  elementColor: breadCrumbLinesColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: node.children!.map((nodeChild) {
                    return Repeat(
                      showCustomizationForRoot: showCustomizationForRoot,
                      breadCrumbLinesColor: breadCrumbLinesColor,
                      toggleNodeView: toggleNodeView,
                      nodeRowConfig: nodeRowConfig,
                      elementsColor: elementsColor,
                      nodeRootId: nodeRootId,
                      node: nodeChild,
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Repeat<T> extends StatelessWidget {
  const Repeat({
    super.key,
    required this.showCustomizationForRoot,
    required this.breadCrumbLinesColor,
    required this.nodeRowConfig,
    required this.elementsColor,
    required this.nodeRootId,
    this.toggleNodeView,
    required this.node,
  });

  final void Function(Node<NodeData<T>> node)? toggleNodeView;
  final NodeRowConfig Function(T? data) nodeRowConfig;
  final bool showCustomizationForRoot;
  final Color breadCrumbLinesColor;
  final Node<NodeData<T>> node;
  final Color elementsColor;
  final int nodeRootId;

  int lineBreadCrumbHeight(Node<NodeData<T>> node) {
    int descendentsShowing = node.numberOfDescendentsShowingUp;

    return (48 * descendentsShowing);
  }

  bool showCustomization() {
    if (node.id == nodeRootId) {
      return showCustomizationForRoot;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NodeRow(
          node,
          showCustomizationForRoot: showCustomization(),
          onPressed: () => toggleNodeView?.call(node),
          breadCrumbLineColor: breadCrumbLinesColor,
          elementsColor: elementsColor,
          nodeRowConfig: nodeRowConfig,
        ),
        Visibility(
          visible: node.expanded,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LineBreadCrumb(
                lineBreadCrumbHeight(node),
                elementColor: breadCrumbLinesColor,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: node.children!.map((nodeChild) {
                  return Repeat(
                    showCustomizationForRoot: showCustomizationForRoot,
                    breadCrumbLinesColor: breadCrumbLinesColor,
                    toggleNodeView: toggleNodeView,
                    nodeRowConfig: nodeRowConfig,
                    elementsColor: elementsColor,
                    nodeRootId: nodeRootId,
                    node: nodeChild,
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
