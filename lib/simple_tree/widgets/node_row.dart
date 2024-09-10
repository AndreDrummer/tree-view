import 'package:flutter/material.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/builder/node.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';

class NodeRow<T> extends StatelessWidget {
  const NodeRow(
    this.node, {
    required this.breadCrumbLineColor,
    required this.elementsColor,
    required this.nodeRowConfig,
    this.onPressed,
    super.key,
  });

  final NodeRowConfig Function(T data) nodeRowConfig;
  final Node<NodeData<T>> node;

  final void Function()? onPressed;
  final Color breadCrumbLineColor;
  final Color elementsColor;

  @override
  Widget build(BuildContext context) {
    NodeRowConfig? nodeConfig;

    if (node.value?.data != null) {
      nodeConfig = nodeRowConfig(node.value!.data as T);
    }

    return Row(
      children: [
        Visibility(
          visible: node.hasChildren,
          replacement: Container(
            color: breadCrumbLineColor,
            height: 1,
            width: 49,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              !node.hasChildren || !node.expanded
                  ? Icons.keyboard_arrow_right_outlined
                  : Icons.keyboard_arrow_down,
              color: elementsColor,
            ),
          ),
        ),
        _prefixIcon(context, nodeConfig),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "${nodeConfig?.title}",
            style: TextStyle(color: elementsColor, fontSize: 18),
          ),
        ),
        _suffixIcon(context, nodeConfig),
      ],
    );
  }

  Widget _suffixIcon(BuildContext context, NodeRowConfig? nodeConfig) {
    if (nodeConfig?.suffixIcon != null) {
      final Color? iconColor =
          nodeConfig?.suffixIconColor ?? Theme.of(context).iconTheme.color;

      return Icon(nodeConfig?.suffixIcon!,
          color: iconColor, size: nodeConfig?.suffixIconSize);
    }
    return Container();
  }

  Widget _prefixIcon(BuildContext context, NodeRowConfig? nodeConfig) {
    if (nodeConfig?.prefixIcon != null) {
      final Color? iconColor =
          nodeConfig?.prefixIconColor ?? Theme.of(context).iconTheme.color;

      return Icon(nodeConfig?.prefixIcon!,
          color: iconColor, size: nodeConfig?.prefixIconSize);
    }
    return Container();
  }
}
