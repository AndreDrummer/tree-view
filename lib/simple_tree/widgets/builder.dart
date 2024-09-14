import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/widgets/nodes.dart';
import 'package:tree_view/simple_tree/builder/node.dart';
import 'package:flutter/material.dart';

Widget builder<T>(
  Node<NodeData<T>> node, {
  required NodeRowConfig Function(T) nodeRowConfig,
  required Function(Node<NodeData<T>>) toggleNode,
  required bool showCustomizationForRoot,
  required Color breadCrumbLinesColor,
  required Color elementsColor,
  required int nodeRootId,
}) {
  return Nodes<T>(
    showCustomizationForRoot: showCustomizationForRoot,
    breadCrumbLinesColor: breadCrumbLinesColor,
    nodeRowConfig: nodeRowConfig,
    elementsColor: elementsColor,
    key: Key(node.id.toString()),
    toggleNode: toggleNode,
    nodeRootId: nodeRootId,
    node: node,
  );
}
