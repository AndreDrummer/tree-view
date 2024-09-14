import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/widgets/builder.dart';
import 'package:flutter/material.dart';
import '../builder/node.dart';

class TreeView<T> extends StatefulWidget {
  const TreeView(
    this.node, {
    super.key,
    required this.showCustomizationForRoot,
    required this.breadCrumbLinesColor,
    required this.horizontalController,
    this.backTopButtonBackgroundColor,
    required this.verticalController,
    this.backTopButtonIconColor,
    required this.nodeRowConfig,
    required this.elementsColor,
    required this.nodeRootId,
    required this.toggleNode,
  });

  final Function(Node<NodeData<T>>) toggleNode;
  final ScrollController horizontalController;
  final Color? backTopButtonBackgroundColor;
  final ScrollController verticalController;
  final Color? backTopButtonIconColor;
  final bool showCustomizationForRoot;
  final Color breadCrumbLinesColor;
  final Node<NodeData<T>> node;
  final Color elementsColor;
  final int nodeRootId;

  // Properties related to the row
  final NodeRowConfig Function(T? data) nodeRowConfig;

  @override
  State<TreeView<T>> createState() => _TreeBuilderState<T>();
}

class _TreeBuilderState<T> extends State<TreeView<T>> {
  late ScrollController horizontalController;
  late ScrollController verticalController;

  @override
  void initState() {
    horizontalController = widget.horizontalController;
    verticalController = widget.verticalController;

    super.initState();
  }

  void scrollToTheBeginningOfData() {
    verticalController.animateTo(
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
      0,
    );
    horizontalController.animateTo(
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
      0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .76,
          width: MediaQuery.sizeOf(context).height,
          child: SingleChildScrollView(
            controller: verticalController,
            child: SingleChildScrollView(
              controller: horizontalController,
              scrollDirection: Axis.horizontal,
              child: builder(
                widget.node,
                showCustomizationForRoot: widget.showCustomizationForRoot,
                breadCrumbLinesColor: widget.breadCrumbLinesColor,
                nodeRowConfig: widget.nodeRowConfig,
                elementsColor: widget.elementsColor,
                nodeRootId: widget.nodeRootId,
                toggleNode: widget.toggleNode,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          right: 24,
          child: FloatingActionButton(
            backgroundColor: widget.backTopButtonBackgroundColor,
            onPressed: scrollToTheBeginningOfData,
            child: Icon(
              color: widget.backTopButtonIconColor,
              Icons.arrow_upward_rounded,
            ),
          ),
        ),
      ],
    );
  }
}
