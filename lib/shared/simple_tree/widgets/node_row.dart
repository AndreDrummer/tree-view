import 'package:flutter/material.dart';
import 'package:tree_view/shared/simple_tree/models/node_data.dart';
import 'package:tree_view/shared/simple_tree/node.dart';

class NodeRow<T> extends StatelessWidget {
  const NodeRow(
    this.node, {
    this.darkModeIsON = true,
    this.prefixIconColor,
    this.suffixIconColor,
    this.prefixIconSize,
    this.suffixIconSize,
    required this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
    super.key,
  });

  final Node<NodeData<T>> node;

  final void Function()? onPressed;
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final double? suffixIconSize;
  final Color? suffixIconColor;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool darkModeIsON;
  final String title;

  @override
  Widget build(BuildContext context) {
    final color = darkModeIsON ? Colors.white : Colors.black;

    return Row(
      children: [
        Visibility(
          visible: node.hasChildren,
          replacement: Container(
            color: darkModeIsON ? Colors.white24 : Colors.black12,
            height: 1,
            width: 49,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              !node.hasChildren || !node.expanded
                  ? Icons.keyboard_arrow_right_outlined
                  : Icons.keyboard_arrow_down,
              color: color,
            ),
          ),
        ),
        _prefixIcon(context),
        TextButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(color: color, fontSize: 18),
          ),
        ),
        _suffixIcon(context),
      ],
    );
  }

  Widget _suffixIcon(BuildContext context) {
    if (suffixIcon != null) {
      final Color? iconColor =
          suffixIconColor ?? Theme.of(context).iconTheme.color;

      return Icon(suffixIcon!, color: iconColor, size: suffixIconSize);
    }
    return Container();
  }

  Widget _prefixIcon(BuildContext context) {
    if (prefixIcon != null) {
      final Color? iconColor =
          prefixIconColor ?? Theme.of(context).iconTheme.color;

      return Icon(prefixIcon!, color: iconColor, size: prefixIconSize);
    }
    return Container();
  }
}
