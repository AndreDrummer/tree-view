import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';
import 'package:tree_view/simple_tree/builder/tree_manager.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/widgets/tree.dart';
import 'package:flutter/material.dart';

class TreeWidget<T> extends StatefulWidget {
  const TreeWidget({
    super.key,
    required this.horizontalScrollController,
    required this.verticalScrollController,
    required this.showCustomizationForRoot,
    required this.breadCrumbLinesColor,
    this.backTopButtonBackgroundColor,
    this.initializeExpanded = true,
    this.showBackTopButton = true,
    this.backTopButtonIconColor,
    required this.elementsColor,
    required this.treeManager,
    this.resetOnFilter = true,
    required this.nodeConfig,
    this.nothingFoundText,
    this.filterPredicate,
    this.backgroundColor,
  });

  final bool Function(ParentProtocol)? filterPredicate;
  final bool showCustomizationForRoot;

  final String? nothingFoundText;
  final bool initializeExpanded;

  final bool showBackTopButton;
  final bool resetOnFilter;

  final ScrollController horizontalScrollController;
  final ScrollController verticalScrollController;

  final TreeManager treeManager;

  final Color? backTopButtonBackgroundColor;
  final Color? backTopButtonIconColor;

  final Color breadCrumbLinesColor;
  final Color? backgroundColor;
  final Color elementsColor;

  // Properties related to the row
  final NodeRowConfig Function(T data) nodeConfig;

  @override
  State<TreeWidget<T>> createState() => _TreeWidgetState<T>();
}

class _TreeWidgetState<T> extends State<TreeWidget<T>> {
  late final ScrollController horizontalScrollController;
  late final ScrollController verticalScrollController;
  late final TreeManager treeManager;

  double backToTopButtonOpacity = 1;

  @override
  void initState() {
    horizontalScrollController = widget.horizontalScrollController;
    verticalScrollController = widget.verticalScrollController;
    treeManager = widget.treeManager;

    super.initState();
  }

  @override
  void didUpdateWidget(TreeWidget<T> oldWidget) {
    treeManager.rebuild(
      shouldResetTree: widget.resetOnFilter,
      widget.filterPredicate!,
    );
    super.didUpdateWidget(oldWidget);
  }

  NodeRowConfig nodeConfig(data) {
    return widget.nodeConfig(data as T);
  }

  void onNodeToggled(node) {
    setState(() {
      treeManager.toogleNodeView(node);
    });
  }

  Widget emptyTreeWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height / 6,
      ),
      child: Text(
        style: TextStyle(color: widget.elementsColor, fontSize: 18),
        widget.nothingFoundText ?? "Nada foi encontrado",
        textAlign: TextAlign.center,
      ),
    );
  }

  bool showCustomizationForRoot() {
    return widget.showCustomizationForRoot;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Visibility(
        visible: treeManager.tree.id > -1,
        replacement: emptyTreeWidget(),
        child: Tree(
          treeManager.tree,
          backTopButtonBackgroundColor: widget.backTopButtonBackgroundColor,
          backTopButtonIconColor: widget.backTopButtonIconColor,
          showCustomizationForRoot: showCustomizationForRoot(),
          breadCrumbLinesColor: widget.breadCrumbLinesColor,
          horizontalController: horizontalScrollController,
          verticalController: verticalScrollController,
          showBackTopButton: widget.showBackTopButton,
          nodeRootId: treeManager.nodeStart().id,
          elementsColor: widget.elementsColor,
          toggleNodeView: onNodeToggled,
          nodeRowConfig: nodeConfig,
        ),
      ),
    );
  }
}
