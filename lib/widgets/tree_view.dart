import 'package:tree_view/widgets/line_bread_crumb.dart';
import 'package:tree_view/models/person.dart';
import 'package:tree_view/widgets/node.dart';
import 'package:flutter/material.dart';

class TreeView extends StatefulWidget {
  const TreeView(this.node, {super.key});

  final Person node;

  @override
  State<TreeView> createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  late final Person node;
  late final List<Person> nodeChildren;
  late final int nodeDescendents;

  @override
  void initState() {
    node = widget.node;
    nodeChildren = node.children;
    nodeDescendents = node.descendents();
    super.initState();
  }

  int lineBreadCrumbHeight() {
    int descendentsShowing = node.numberOfDescendentsShowingUp();

    return (48 * descendentsShowing);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Node(node),
        Visibility(
          visible: node.expanded,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LineBreadCrumb(lineBreadCrumbHeight()),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: node.children.map((child) {
                    return TreeView(child);
                  }).toList()),
            ],
          ),
        ),
      ],
    );
  }
}
