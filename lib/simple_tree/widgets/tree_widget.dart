import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';
import 'package:tree_view/simple_tree/builder/tree_manager.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/widgets/tree.dart';
import 'package:flutter/material.dart';

class TreeWidget<T> extends StatefulWidget {
  const TreeWidget({
    super.key,
    required this.horizontalScrollController,
    this.alwaysScrollToTheEndOfTree = true,
    required this.verticalScrollController,
    required this.showCustomizationForRoot,
    required this.breadCrumbLinesColor,
    this.backTopButtonBackgroundColor,
    this.initializeExpanded = true,
    this.showBackTopButton = true,
    this.backTopButtonIconColor,
    required this.elementsColor,
    this.resetOnFilter = true,
    required this.nodeConfig,
    required this.dataList,
    required this.rootData,
    this.nothingFoundText,
    this.filterPredicate,
    this.backgroundColor,
  });

  final bool Function(ParentProtocol)? filterPredicate;
  final bool alwaysScrollToTheEndOfTree;
  final bool showCustomizationForRoot;
  final String? nothingFoundText;
  final bool initializeExpanded;
  final bool showBackTopButton;
  final List<ParentProtocol> dataList;
  final bool resetOnFilter;
  final ParentProtocol rootData;

  final ScrollController horizontalScrollController;
  final ScrollController verticalScrollController;

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
  late final TreeManager _treeInstance;

  double backToTopButtonOpacity = 1;

  @override
  void initState() {
    _treeInstance = TreeManager.instance(
      dataList: widget.dataList,
      initializeExpanded: widget.initializeExpanded,
      rootData: NodeData<ParentProtocol>(
        id: widget.rootData.id,
        data: widget.rootData,
      ),
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

  Widget emptyTreeWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height / 6,
      ),
      child: Text(
        style: TextStyle(color: widget.elementsColor, fontSize: 18),
        widget.nothingFoundText ?? "Nada foi encontrado",
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
      child: _treeInstance.tree.id == -1
          ? emptyTreeWidget()
          : Tree(
              _treeInstance.tree,
              backTopButtonBackgroundColor: widget.backTopButtonBackgroundColor,
              alwaysScrollToTheEndOfTree: widget.alwaysScrollToTheEndOfTree,
              backTopButtonIconColor: widget.backTopButtonIconColor,
              showCustomizationForRoot: showCustomizationForRoot(),
              breadCrumbLinesColor: widget.breadCrumbLinesColor,
              horizontalController: horizontalScrollController,
              verticalController: verticalScrollController,
              showBackTopButton: widget.showBackTopButton,
              nodeRootId: _treeInstance.nodeStart().id,
              elementsColor: widget.elementsColor,
              toggleNodeView: onNodeToggled,
              nodeRowConfig: nodeConfig,
            ),
    );
  }
}
