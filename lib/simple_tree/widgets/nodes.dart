import 'package:tree_view/simple_tree/widgets/node_widget.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/builder/node.dart';
import 'package:flutter/material.dart';

class Nodes<T> extends StatelessWidget {
  const Nodes({
    super.key,
    required this.showCustomizationForRoot,
    required this.breadCrumbLinesColor,
    required this.maxChildrenVisible,
    required this.nodeRowConfig,
    required this.elementsColor,
    required this.nodeRootId,
    required this.node,
  });

  final NodeRowConfig Function(T) nodeRowConfig;
  final bool showCustomizationForRoot;
  final Color breadCrumbLinesColor;
  final int maxChildrenVisible;
  final Node<NodeData<T>> node;
  final Color elementsColor;
  final int nodeRootId;

  @override
  Widget build(BuildContext context) {
    return NodeWidget(
      node,
      showCustomizationForRoot: showCustomizationForRoot,
      breadCrumbLineColor: breadCrumbLinesColor,
      maxChildrenVisible: maxChildrenVisible,
      elementsColor: elementsColor,
      nodeRowConfig: nodeRowConfig,
      nodeRootId: nodeRootId,
    );
  }
}
