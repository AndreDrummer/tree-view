import 'package:tree_view/core/node/node.dart';
import 'package:flutter/material.dart';
import 'package:tree_view/models/person.dart';

class NodeRow extends StatelessWidget {
  const NodeRow(this.item, {this.onPressed, super.key});

  final void Function()? onPressed;
  final Node<Person> item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            item.children!.isEmpty || !item.expanded
                ? Icons.keyboard_arrow_right_outlined
                : Icons.keyboard_arrow_down,
            color: Colors.white,
          ),
        ),
        Text(
          item.data.name,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }
}
