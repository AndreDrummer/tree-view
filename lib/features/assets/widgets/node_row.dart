import 'package:tree_view/core/tree/node.dart';
import 'package:flutter/material.dart';
import 'package:tree_view/core/models/person.dart';

class NodeRow extends StatelessWidget {
  const NodeRow(
    this.node, {
    this.onPressed,
    super.key,
    this.darkModeIsON = true,
  });

  final void Function()? onPressed;
  final Node<Person> node;
  final bool darkModeIsON;

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
              node.children!.isEmpty || !node.expanded
                  ? Icons.keyboard_arrow_right_outlined
                  : Icons.keyboard_arrow_down,
              color: color,
            ),
          ),
        ),
        prefixIcon(color),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "${node.data?.name}",
            style: TextStyle(color: color, fontSize: 18),
          ),
        ),
        suffixIcon(context),
      ],
    );
  }

  Widget suffixIcon(BuildContext context) {
    final fat = node.data?.fat ?? false;
    final IconData icon = fat ? Icons.lens_rounded : Icons.flash_on_rounded;
    final iconColor = fat ? Colors.redAccent : Colors.greenAccent;

    return Icon(icon, color: iconColor, size: fat ? 8 : 16);
  }

  Widget prefixIcon(Color prefixIconColor) {
    final male = node.data?.male ?? false;
    final IconData icon = male ? Icons.man_outlined : Icons.woman_outlined;

    return Icon(icon, color: prefixIconColor);
  }
}
