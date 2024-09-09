import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/widgets/horizontal_scroll.dart';
import 'package:tree_view/simple_tree/widgets/line_bread_crumb.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/widgets/node_row.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../builder/node.dart';

class Tree<T> extends StatelessWidget {
  const Tree(
    this.node, {
    super.key,
    required this.horizontalController,
    required this.breadCrumbLinesColor,
    this.allowHorizontalScrool = true,
    this.scrollToTheEndOfData = true,
    this.allowVerticalScrool = true,
    required this.elementsColor,
    required this.nodeRowConfig,
    this.toggleNodeView,
  });

  final void Function(Node<NodeData<T>> node)? toggleNodeView;
  final ScrollController horizontalController;
  final Color breadCrumbLinesColor;
  final bool allowHorizontalScrool;
  final bool scrollToTheEndOfData;
  final bool allowVerticalScrool;
  final Node<NodeData<T>> node;
  final Color elementsColor;

  // Properties related to the row
  final NodeRowConfig Function(T data) nodeRowConfig;

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
              horizontalController: horizontalController,
              viewWidth:
                  (sizeOfContext.width * (node.getHeightFromNodeToRoot + 1)),
              viewHeight: lineBreadCrumbHeight().toDouble() + 50,
              allowHorizontalScrool: allowHorizontalScrool,
              scrollToTheEndOfData:
                  scrollToTheEndOfData && controller.isFilteringByAny,
              jumpTo: node.getHeight.toDouble(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NodeRow(
                    node,
                    onPressed: () => toggleNodeView?.call(node),
                    breadCrumbLineColor: breadCrumbLinesColor,
                    elementsColor: elementsColor,
                    nodeRowConfig: nodeRowConfig,
                  ),
                  Visibility(
                    visible: node.expanded,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LineBreadCrumb(
                          lineBreadCrumbHeight(),
                          elementColor: breadCrumbLinesColor,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: node.children!.map((child) {
                            return Tree(
                              child,
                              toggleNodeView: (node) {
                                toggleNodeView?.call(node);
                              },
                              breadCrumbLinesColor: breadCrumbLinesColor,
                              horizontalController: ScrollController(),
                              allowHorizontalScrool: false,
                              elementsColor: elementsColor,
                              scrollToTheEndOfData: false,
                              allowVerticalScrool: false,
                              nodeRowConfig: nodeRowConfig,
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
