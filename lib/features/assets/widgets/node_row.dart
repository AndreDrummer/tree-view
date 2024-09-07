import 'package:tree_view/core/tree/node.dart';
import 'package:flutter/material.dart';
import 'package:tree_view/core/models/person.dart';

class NodeRow extends StatelessWidget {
  const NodeRow(this.item,
      {this.onPressed, super.key, this.darkModeIsON = true});

  final void Function()? onPressed;
  final Node<Person> item;
  final bool darkModeIsON;

  @override
  Widget build(BuildContext context) {
    final color = darkModeIsON ? Colors.white : Colors.black;

    return Row(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            item.children!.isEmpty || !item.expanded
                ? Icons.keyboard_arrow_right_outlined
                : Icons.keyboard_arrow_down,
            color: color,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            item.data.name,
            style: TextStyle(color: color, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
