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
    required this.breadCrumbLinesColor,
    this.alwaysScrollToTheEndOfTree = true,
    this.initializeExpanded = true,
    this.showBackTopButton = true,
    required this.elementsColor,
    this.resetOnFilter = true,
    required this.nodeConfig,
    required this.dataList,
    this.filterPredicate,
    this.backgroundColor,
  });

  final bool Function(Parent)? filterPredicate;
  final bool alwaysScrollToTheEndOfTree;
  final bool initializeExpanded;
  final bool showBackTopButton;
  final List<Parent> dataList;
  final bool resetOnFilter;

  final ScrollController horizontalScrollController;
  final ScrollController verticalScrollController;

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
  late final TreeManager _treeInstance;

  double backToTopButtonOpacity = 1;

  @override
  void initState() {
    _treeInstance = TreeManager.instance(
      widget.dataList,
      widget.initializeExpanded,
    );
    horizontalScrollController = widget.horizontalScrollController;
    verticalScrollController = widget.verticalScrollController;

    super.initState();
  }

  @override
  void didUpdateWidget(TreeWidget<T> oldWidget) {
    if (widget.filterPredicate != null) {
      _treeInstance.rebuild(
        shouldResetTree: widget.resetOnFilter,
        widget.filterPredicate!,
      );
    }

    super.didUpdateWidget(oldWidget);
  }

  NodeRowConfig nodeConfig(data) {
    return widget.nodeConfig(data as T);
  }

  void onNodeToggled(node) {
    setState(() {
      _treeInstance.toogleNodeView(node);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Tree(
        _treeInstance.treeRoot,
        breadCrumbLinesColor: widget.breadCrumbLinesColor,
        alwaysScrollToTheEndOfTree: widget.alwaysScrollToTheEndOfTree,
        horizontalController: horizontalScrollController,
        verticalController: verticalScrollController,
        showBackTopButton: widget.showBackTopButton,
        elementsColor: widget.elementsColor,
        toggleNodeView: onNodeToggled,
        nodeRowConfig: nodeConfig,
      ),
    );
  }
}
