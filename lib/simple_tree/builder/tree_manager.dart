import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/utils/extensions.dart';
import 'package:tree_view/simple_tree/builder/node.dart';
import 'package:tree_view/simple_tree/utils/utils.dart';
import 'package:flutter/foundation.dart';

enum BuildTreeMode {
  onMain,
  onSpawnIsolate,
}

class TreeManager<T extends ParentProtocol> {
  TreeManager._(
    bool initializeExpanded,
    NodeData<T> rootData,
    List<T> dataList,
  )   : _initializeExpanded = initializeExpanded,
        _rootData = rootData,
        _dataList = dataList;

  final bool _initializeExpanded;
  final NodeData<T> _rootData;
  final List<T> _dataList;

  static TreeManager? _instance;

  static TreeManager get instance {
    if (_instance == null) {
      throw Exception(
          'TreeManager is not initialized yet. Call TreeManager.initialize() first.');
    }

    return _instance!;
  }

  factory TreeManager.initialize({
    required bool initializeExpanded,
    required NodeData<T> rootData,
    required List<T> dataList,
  }) {
    _instance ??= TreeManager._(initializeExpanded, rootData, dataList);
    return _instance! as TreeManager<T>;
  }

  bool _semaphor = true;

  /// This is representation of a empty tree.
  final Node<NodeData<T>> emptyTree = Node<NodeData<T>>(
    value: NodeData(id: -1),
    expanded: false,
    id: -1,
  );

  late Node<NodeData<T>> _tree;

  Node<NodeData<T>> get tree => _tree;

  Node<NodeData<T>> nodeStart() {
    return Node(
      expanded: _initializeExpanded,
      value: _rootData,
      id: 9999,
    );
  }

  void buildTree() {
    final startTime = Utils.startExecutionTime(methodName: "buildTree");
    _tree = _buildTree(BuildTreeMode.onMain);
    Utils.endExecutionTime(startTime, methodName: "buildTree");
  }

  Future<void> buildTreeOnIsolate() async {
    late DateTime startTime;

    try {
      if (_semaphor) {
        startTime = Utils.startExecutionTime(
          methodName: "buildTreeOnIsolate",
        );

        _semaphor = false;
        _tree = await compute(_buildTree, BuildTreeMode.onSpawnIsolate);
        _semaphor = true;

        Utils.endExecutionTime(startTime, methodName: "buildTreeOnIsolate");
      }
    } catch (err, stack) {
      debugPrint("Error running buildTreeOnIsolate: $err");
      debugPrint("Stack Trace: $stack");

      Utils.endExecutionTime(startTime, methodName: "buildTreeOnIsolate");
      rethrow;
    }
  }

  /// This is the initial tree mounted. It never changes.
  Node<NodeData<T>> _buildTree(
    BuildTreeMode? buildTreeMode,
  ) {
    debugPrint("BuildTree Mode: ${buildTreeMode ?? BuildTreeMode.onMain}.");
    debugPrint("Data Length: ${_dataList.length} items.");

    final List<NodeData<T>> nodeDataList = _dataList.toNodeDataList();

    final Map<String, Node<NodeData<T>>> nodeMap =
        <String, Node<NodeData<T>>>{};

    final startNode = nodeStart();

    nodeMap[startNode.value?.data?.id] = startNode;

    for (final nodeData in nodeDataList) {
      if (nodeData.data == null) continue;

      Node<NodeData<T>> node = Node<NodeData<T>>(
        expanded: _initializeExpanded,
        id: nodeData.id,
        value: nodeData,
      );

      nodeMap[node.value?.data?.id] = node;

      Node<NodeData<T>>? nodeParent = nodeMap[nodeData.data?.parentId];

      if (nodeParent != null) {
        nodeParent.children!.addChild(node);
        node.parent = nodeParent;
      } else {
        startNode.children!.addChild(node);
        node.parent = startNode;
      }
    }

    return startNode;
  }

  Node<NodeData>? filteredTree({
    required bool Function(ParentProtocol) filterPredicate,
    Node<NodeData>? node,
  }) {
    node ??= tree;

    if (node.isEmpty) return null;

    List<Node<NodeData>> filteredChildren = [];

    for (var child in node.children!) {
      var filteredChild = filteredTree(
        filterPredicate: filterPredicate,
        node: child,
      );
      if (filteredChild != null) {
        filteredChildren.add(filteredChild);
      }
    }

    bool shouldIncludeCurrentNode =
        filterPredicate(node.value!.data) || filteredChildren.isNotEmpty;

    if (shouldIncludeCurrentNode) {
      return Node<NodeData>(
        children: filteredChildren,
        parent: node.parent,
        value: node.value,
        expanded: true,
        id: node.id,
      );
    }

    return null;
  }
}
