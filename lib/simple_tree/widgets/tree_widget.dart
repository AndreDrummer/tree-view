import 'package:tree_view/simple_tree/builder/node.dart';
import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';
import 'package:tree_view/simple_tree/builder/tree_manager.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/models/node_row_dto.dart';
import 'package:tree_view/simple_tree/widgets/tree_view.dart';
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
    required this.filterPredicate,
    this.backTopButtonIconColor,
    required this.elementsColor,
    required this.treeManager,
    this.resetOnFilter = true,
    required this.nodeConfig,
    this.nothingFoundText,
    this.backgroundColor,
  });

  final bool Function(ParentProtocol) filterPredicate;
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

  NodeRowConfig nodeConfig(data) {
    return widget.nodeConfig(data as T);
  }

  Widget emptyTreeView() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height / 6,
      ),
      child: Text(
        style: TextStyle(color: widget.elementsColor, fontSize: 18),
        widget.nothingFoundText ?? "Nothing found",
        textAlign: TextAlign.center,
      ),
    );
  }

  Node<NodeData>? filteredTree(Node<NodeData> node) {
    if (node.isEmpty) return null;

    List<Node<NodeData>> filteredChildren = [];

    for (var child in node.children!) {
      var filteredChild = filteredTree(child);
      if (filteredChild != null) {
        filteredChildren.add(filteredChild);
      }
    }

    bool shouldIncludeCurrentNode =
        widget.filterPredicate(node.value!.data) || filteredChildren.isNotEmpty;

    if (shouldIncludeCurrentNode) {
      // Include the current node, but with the filtered children
      return Node<NodeData>(
        expanded: filteredChildren.length <= 150,
        children: filteredChildren,
        parent: node.parent,
        value: node.value,
        id: node.id,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Node<NodeData> originalTree = treeManager.tree;
    final root = filteredTree(originalTree) ?? treeManager.emptyTree;

    return Container(
      color: widget.backgroundColor,
      child: Visibility(
        visible: root.isNotEmpty,
        replacement: emptyTreeView(),
        child: TreeView(
          root,
          backTopButtonBackgroundColor: widget.backTopButtonBackgroundColor,
          showCustomizationForRoot: widget.showCustomizationForRoot,
          backTopButtonIconColor: widget.backTopButtonIconColor,
          breadCrumbLinesColor: widget.breadCrumbLinesColor,
          horizontalController: horizontalScrollController,
          verticalController: verticalScrollController,
          nodeRootId: treeManager.nodeStart().id,
          elementsColor: widget.elementsColor,
          nodeRowConfig: nodeConfig,
        ),
      ),
    );
  }
}
