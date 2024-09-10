import 'package:flutter/material.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/widgets/line_bread_crumb.dart';
import 'package:tree_view/simple_tree/widgets/node_row.dart';
import 'package:tree_view/simple_tree/widgets/tree.dart';

import '../builder/node.dart';

class TreeBuilder<T> extends StatelessWidget {
  const TreeBuilder(
    this.node, {
    super.key,
    this.toggleNodeView,
    required this.breadCrumbLinesColor,
    required this.horizontalController,
    required this.allowHorizontalScrool,
    required this.scrollToTheEndOfData,
    required this.allowVerticalScrool,
    required this.verticalController,
    required this.elementsColor,
    required this.nodeRowConfig,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NodeRow(
          node,
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
                lineBreadCrumbHeight(),
                elementColor: breadCrumbLinesColor,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: node.children!.map((nodeChild) {
                  return Tree(
                    nodeChild,
                    breadCrumbLinesColor: breadCrumbLinesColor,
                    horizontalController: ScrollController(),
                    verticalController: ScrollController(),
                    toggleNodeView: toggleNodeView,
                    nodeRowConfig: nodeRowConfig,
                    allowHorizontalScrool: false,
                    elementsColor: elementsColor,
                    scrollToTheEndOfData: false,
                    allowVerticalScrool: false,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
