import 'package:tree_view/features/assets/widgets/horizontal_scroll.dart';
import 'package:tree_view/features/assets/widgets/line_bread_crumb.dart';
import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/assets/widgets/node_row.dart';
import 'package:tree_view/core/models/person.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import '../../../core/tree/node.dart';

class TreeView extends StatelessWidget {
  const TreeView(
    this.node, {
    super.key,
    this.toggleNodeView,
    this.allowHorizontalScrool = true,
    this.allowVerticalScrool = true,
    this.darkModeIsON = true,
  });
  final void Function(Node<Person> node)? toggleNodeView;
  final bool allowHorizontalScrool;
  final bool allowVerticalScrool;
  final bool darkModeIsON;
  final Node<Person> node;

  int lineBreadCrumbHeight() {
    int descendentsShowing = node.numberOfDescendentsShowingUp;

    return (48 * descendentsShowing);
  }

  @override
  Widget build(BuildContext context) {
    final sizeOfContext = MediaQuery.sizeOf(context);

    return Consumer<HomeController>(
      builder: (context, homeController, _) {
        return Consumer<AssetsController>(
          builder: (context, controller, _) {
            return HorizontalScroll(
              viewWidth: (sizeOfContext.width * (node.getHeightUntilRoot + 1)),
              viewHeight: lineBreadCrumbHeight().toDouble() + 50,
              allowHorizontalScrool: allowHorizontalScrool,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NodeRow(
                    node,
                    onPressed: () => toggleNodeView?.call(node),
                    darkModeIsON: darkModeIsON,
                  ),
                  Visibility(
                    visible: node.expanded,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LineBreadCrumb(
                          lineBreadCrumbHeight(),
                          darkModeIsON: darkModeIsON,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: node.children!.map((child) {
                            return TreeView(
                              child,
                              toggleNodeView: (node) {
                                toggleNodeView?.call(node);
                              },
                              allowHorizontalScrool: false,
                              darkModeIsON: darkModeIsON,
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
          },
        );
      },
    );
  }
}
