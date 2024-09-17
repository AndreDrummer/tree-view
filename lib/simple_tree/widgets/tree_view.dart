import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/widgets/builder.dart';
import 'package:flutter/material.dart';
import '../builder/node.dart';
import 'dart:math';

class TreeView<T> extends StatefulWidget {
  const TreeView(
    this.node, {
    required this.showCustomizationForRoot,
    required this.breadCrumbLinesColor,
    required this.horizontalController,
    this.backTopButtonBackgroundColor,
    required this.verticalController,
    this.backTopButtonIconColor,
    required this.nodeRowConfig,
    required this.elementsColor,
    required this.nodeRootId,
    super.key,
  });

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
  int numberOfChildrenToShow = 150;

  @override
  void initState() {
    horizontalController = widget.horizontalController;
    verticalController = widget.verticalController;

    verticalController.addListener(() {
      final maxPosition = verticalController.position.maxScrollExtent.toInt();
      final currentPosition = verticalController.offset.toInt();

      if (currentPosition == maxPosition) {
        setState(() {
          calculateNumberOfChildrenToShow();
        });
      }
    });

    super.initState();
  }

  int calculateNumberOfChildrenToShow() {
    if (numberOfChildrenToShow < widget.node.numberOfChildren) {
      numberOfChildrenToShow +=
          min(150, widget.node.numberOfChildren - numberOfChildrenToShow);
    }
    return numberOfChildrenToShow;
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
          height: MediaQuery.sizeOf(context).height * .8,
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
                maxChildrenVisible: numberOfChildrenToShow,
                nodeRowConfig: widget.nodeRowConfig,
                elementsColor: widget.elementsColor,
                nodeRootId: widget.nodeRootId,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 48,
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
