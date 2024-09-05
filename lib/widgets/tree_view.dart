import 'package:tree_view/widgets/line_bread_crumb.dart';
import 'package:tree_view/models/person.dart';
import 'package:tree_view/widgets/node.dart';
import 'package:flutter/material.dart';

class TreeView extends StatelessWidget {
  const TreeView(this.node, {super.key, this.toggleNodeView});
  final void Function(Person node)? toggleNodeView;
  final Person node;

  int lineBreadCrumbHeight() {
    int descendentsShowing = node.numberOfDescendentsShowingUp;

    return (48 * descendentsShowing);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Node(node, onPressed: () => toggleNodeView?.call(node)),
        Visibility(
          visible: node.expanded,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LineBreadCrumb(lineBreadCrumbHeight()),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: node.children.map((child) {
                    return TreeView(child,
                        toggleNodeView: (node) => toggleNodeView?.call(node));
                  }).toList()),
            ],
          ),
        ),
      ],
    );
  }
}
