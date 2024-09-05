import 'package:flutter/material.dart';
import 'package:tree_view/models/person.dart';

class Node extends StatelessWidget {
  const Node(this.item, {super.key});

  final Person item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            item.children.isEmpty || !item.expanded
                ? Icons.keyboard_arrow_right_outlined
                : Icons.keyboard_arrow_down,
            color: Colors.white,
          ),
        ),
        Text(
          item.name,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }
}
