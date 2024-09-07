import 'package:tree_view/widgets/line_bread_crumb.dart';
import 'package:tree_view/widgets/node_row.dart';
import 'package:tree_view/models/person.dart';
import 'package:tree_view/widgets/horizontal_scroll.dart';
import 'package:flutter/material.dart';
import '../core/node/node.dart';

class TreeView extends StatelessWidget {
  const TreeView(
    this.node, {
    super.key,
    this.toggleNodeView,
    this.allowHorizontalScrool = true,
    this.allowVerticalScrool = true,
  });
  final void Function(Node<Person> node)? toggleNodeView;
  final bool allowHorizontalScrool;
  final bool allowVerticalScrool;
  final Node<Person> node;

  int lineBreadCrumbHeight() {
    int descendentsShowing = node.numberOfDescendentsShowingUp;

    return (48 * descendentsShowing);
  }

  @override
  Widget build(BuildContext context) {
    final sizeOfContext = MediaQuery.sizeOf(context);

    return HorizontalScroll(
      viewWidth: (sizeOfContext.width * (node.getHeightUntilRoot + 1)),
      viewHeight: lineBreadCrumbHeight().toDouble() + 50,
      allowHorizontalScrool: allowHorizontalScrool,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NodeRow(node, onPressed: () => toggleNodeView?.call(node)),
          Visibility(
            visible: node.expanded,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LineBreadCrumb(lineBreadCrumbHeight()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: node.children!.map((child) {
                    return TreeView(
                      child,
                      toggleNodeView: (node) {
                        toggleNodeView?.call(node);
                      },
                      allowHorizontalScrool: false,
                      allowVerticalScrool: false,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
