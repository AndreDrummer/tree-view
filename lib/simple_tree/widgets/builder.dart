import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/widgets/nodes.dart';
import 'package:tree_view/simple_tree/builder/node.dart';
import 'package:flutter/material.dart';

Widget builder<T>(
  Node<NodeData<T>> node, {
  required NodeRowConfig Function(T) nodeRowConfig,
  required bool showCustomizationForRoot,
  required Color breadCrumbLinesColor,
  required int maxChildrenVisible,
  required Color elementsColor,
  required int nodeRootId,
}) {
  return Nodes<T>(
    showCustomizationForRoot: showCustomizationForRoot,
    breadCrumbLinesColor: breadCrumbLinesColor,
    maxChildrenVisible: maxChildrenVisible,
    nodeRowConfig: nodeRowConfig,
    elementsColor: elementsColor,
    nodeRootId: nodeRootId,
    key: UniqueKey(),
    node: node,
  );
}
