import 'package:tree_view/simple_tree/widgets/line_bread_crumb.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/widgets/node_row.dart';
import 'package:flutter/material.dart';
import '../builder/node.dart';

class TreeBuilder<T> extends StatefulWidget {
  const TreeBuilder(
    this.node, {
    super.key,
    this.toggleNodeView,
    required this.showCustomizationForRoot,
    required this.breadCrumbLinesColor,
    required this.horizontalController,
    required this.allowHorizontalScrool,
    this.backTopButtonBackgroundColor,
    required this.allowVerticalScrool,
    required this.verticalController,
    required this.showBackTopButton,
    this.backTopButtonIconColor,
    required this.nodeRowConfig,
    required this.elementsColor,
    required this.nodeRootId,
  });

  final void Function(Node<NodeData<T>> node)? toggleNodeView;
  final ScrollController horizontalController;
  final Color? backTopButtonBackgroundColor;
  final ScrollController verticalController;
  final Color? backTopButtonIconColor;
  final bool showCustomizationForRoot;
  final Color breadCrumbLinesColor;
  final bool allowHorizontalScrool;
  final bool allowVerticalScrool;
  final Node<NodeData<T>> node;
  final bool showBackTopButton;
  final Color elementsColor;
  final int nodeRootId;

  // Properties related to the row
  final NodeRowConfig Function(T? data) nodeRowConfig;

  @override
  State<TreeBuilder<T>> createState() => _TreeBuilderState<T>();
}

class _TreeBuilderState<T> extends State<TreeBuilder<T>> {
  late ScrollController horizontalController;
  late ScrollController verticalController;
  double backToTopButtonOpacity = 0.0;

  @override
  void initState() {
    horizontalController = widget.horizontalController;
    verticalController = widget.verticalController;

    verticalController.addListener(() {
      setState(() {
        backToTopButtonOpacity = verticalController.offset > 0 ? 1.0 : 0.0;
      });
    });

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

  int lineBreadCrumbHeight(Node<NodeData<T>> node) {
    int descendentsShowing = node.numberOfDescendentsShowingUp;

    return (48 * descendentsShowing);
  }

  bool showCustomization() {
    if (widget.node.id == widget.nodeRootId) {
      return widget.showCustomizationForRoot;
    }
    return true;
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
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: horizontalController,
                    scrollDirection: Axis.horizontal,
                    child: NestedNodes(
                      showCustomizationForRoot: widget.showCustomizationForRoot,
                      breadCrumbLinesColor: widget.breadCrumbLinesColor,
                      toggleNodeView: widget.toggleNodeView,
                      nodeRowConfig: widget.nodeRowConfig,
                      elementsColor: widget.elementsColor,
                      nodeRootId: widget.nodeRootId,
                      node: widget.node,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          right: 24,
          child: Visibility(
            visible: (widget.showBackTopButton && widget.allowVerticalScrool),
            child: AnimatedOpacity(
              duration: Durations.extralong4,
              opacity: backToTopButtonOpacity,
              child: FloatingActionButton(
                backgroundColor: widget.backTopButtonBackgroundColor,
                onPressed: scrollToTheBeginningOfData,
                child: Icon(
                  color: widget.backTopButtonIconColor,
                  Icons.arrow_upward_rounded,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NestedNodes<T> extends StatelessWidget {
  const NestedNodes({
    super.key,
    required this.showCustomizationForRoot,
    required this.breadCrumbLinesColor,
    required this.nodeRowConfig,
    required this.elementsColor,
    required this.nodeRootId,
    this.toggleNodeView,
    required this.node,
  });

  final void Function(Node<NodeData<T>> node)? toggleNodeView;
  final NodeRowConfig Function(T? data) nodeRowConfig;
  final bool showCustomizationForRoot;
  final Color breadCrumbLinesColor;
  final Node<NodeData<T>> node;
  final Color elementsColor;
  final int nodeRootId;

  int lineBreadCrumbHeight(Node<NodeData<T>> node) {
    int descendentsShowing = node.numberOfDescendentsShowingUp;

    return (48 * descendentsShowing);
  }

  bool showCustomization() {
    if (node.id == nodeRootId) {
      return showCustomizationForRoot;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NodeRow(
          node,
          showCustomizationForRoot: showCustomization(),
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
                lineBreadCrumbHeight(node),
                elementColor: breadCrumbLinesColor,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: node.children!.map((nodeChild) {
                  return NestedNodes(
                    showCustomizationForRoot: showCustomizationForRoot,
                    breadCrumbLinesColor: breadCrumbLinesColor,
                    toggleNodeView: toggleNodeView,
                    nodeRowConfig: nodeRowConfig,
                    elementsColor: elementsColor,
                    nodeRootId: nodeRootId,
                    node: nodeChild,
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
