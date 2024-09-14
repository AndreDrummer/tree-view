import 'package:tree_view/simple_tree/widgets/node_widget.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/widgets/builder.dart';
import 'package:tree_view/simple_tree/builder/node.dart';
import 'package:flutter/material.dart';

class Nodes<T> extends StatefulWidget {
  const Nodes({
    super.key,
    required this.showCustomizationForRoot,
    required this.breadCrumbLinesColor,
    required this.nodeRowConfig,
    required this.elementsColor,
    required this.nodeRootId,
    required this.node,
  });

  final NodeRowConfig Function(T) nodeRowConfig;
  final bool showCustomizationForRoot;
  final Color breadCrumbLinesColor;
  final Node<NodeData<T>> node;
  final Color elementsColor;
  final int nodeRootId;

  @override
  State<Nodes<T>> createState() => _NestedNodesState<T>();
}

class _NestedNodesState<T> extends State<Nodes<T>> {
  late Node<NodeData<T>> node;

  @override
  void initState() {
    node = widget.node;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NodeWidget(
          node,
          showCustomizationForRoot: widget.showCustomizationForRoot,
          breadCrumbLineColor: widget.breadCrumbLinesColor,
          elementsColor: widget.elementsColor,
          nodeRowConfig: widget.nodeRowConfig,
          nodeRootId: widget.nodeRootId,
          toggleNode: () {
            setState(() {
              node = node.expanded ? node.close() : node.open();
            });
          },
        ),
        Visibility(
          visible: node.expanded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: node.children!.map((nodeChild) {
              return builder(
                nodeChild,
                showCustomizationForRoot: widget.showCustomizationForRoot,
                breadCrumbLinesColor: widget.breadCrumbLinesColor,
                nodeRowConfig: widget.nodeRowConfig,
                elementsColor: widget.elementsColor,
                nodeRootId: widget.nodeRootId,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
