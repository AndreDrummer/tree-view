import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
import 'package:tree_view/simple_tree/utils/extensions.dart';
import 'package:tree_view/simple_tree/builder/node.dart';
import 'package:tree_view/simple_tree/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';

enum BuildTreeMode {
  onMain,
  onSpawnIsolate,
}

class TreeManager<T extends ParentProtocol> {
  TreeManager({
    required bool initializeExpanded,
    required NodeData<T> rootData,
    required List<T> dataList,
  })  : _initializeExpanded = initializeExpanded,
        _rootData = rootData,
        _dataList = dataList;

  // Is is changed constantly to reflect the data dynamicity.
  final bool _initializeExpanded;
  final NodeData<T> _rootData;
  final List<T> _dataList;

  /// This is representation of a empty tree.
  final Node<NodeData<T>> _emptyTree = Node<NodeData<T>>(
    value: NodeData(id: -1),
    expanded: false,
    id: -1,
  );

  late Node<NodeData<T>> _tree;

  Node<NodeData<T>> get tree => _tree;

  bool get treeIsNotEmpty => _tree.id != _emptyTree.id;

  Node<NodeData<T>> nodeStart() {
    return Node(
      expanded: _initializeExpanded,
      value: _rootData,
      id: 9999,
    );
  }

  void buildTree() {
    final startTime = Utils.startExecutionTime(methodName: "buildTree");
    _tree = _referenceTree(BuildTreeMode.onMain);
    Utils.endExecutionTime(startTime, methodName: "buildTree");
  }

  Future<void> buildTreeOnIsolate() async {
    final startTime = Utils.startExecutionTime(
      methodName: "buildTreeOnIsolate",
    );

    try {
      _tree = await compute(_referenceTree, BuildTreeMode.onSpawnIsolate);
    } catch (err, stack) {
      debugPrint("Error running buildTreeOnIsolate: $err");
      debugPrint("Stack Trace: $stack");
      rethrow;
    }
    Utils.endExecutionTime(startTime, methodName: "buildTreeOnIsolate");
  }

  void _updateTree(Node<NodeData<T>> node) {
    _tree = node;
  }

  void _resetTree() {
    buildTreeOnIsolate();
  }

  /// This is the initial tree mounted. It never changes.
  Node<NodeData<T>> _referenceTree(
    BuildTreeMode? buildTreeMode,
  ) {
    debugPrint("BuildTree Mode: ${buildTreeMode ?? BuildTreeMode.onMain}.");
    debugPrint("Data Length: ${_dataList.length} items.");
    final List<NodeData<T>> nodeDataList = _dataList.toNodeDataList();

    final startNode = nodeStart();

    for (final nodeData in nodeDataList) {
      Node<NodeData<T>> node = Node<NodeData<T>>(
        expanded: _initializeExpanded,
        id: nodeData.id,
        value: nodeData,
      );

      Node<NodeData<T>>? nodeParent = bfsTraversal(
        startNoode: startNode,
        predicate: (innerNode) {
          return innerNode.value?.data?.id == nodeData.data?.parentId;
        },
      );

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

  void toogleNodeView(Node<NodeData<T>> node, {bool shouldResetTree = false}) {
    if (shouldResetTree) _resetTree();

    final updatedNode = node.expanded ? node.close() : node.open();

    final newNode = tree.toggleNode(updatedNode);

    if (node.id == tree.id) _updateTree(newNode ?? _emptyTree);
  }

  Node<NodeData<T>>? bfsTraversal({
    bool Function(Node<NodeData<T>>)? predicate,
    required Node<NodeData<T>> startNoode,
    void Function(Node<NodeData<T>>)? process,
  }) {
    // Initialize a queue and add the root node
    Queue<Node<NodeData<T>>> queue = Queue<Node<NodeData<T>>>();
    Node<NodeData<T>> currentNode = startNoode;
    queue.add(startNoode);

    // Traverse while there are nodes in the queue
    while (queue.isNotEmpty) {
      // Dequeue the front node
      Node<NodeData<T>> current = queue.removeFirst();
      currentNode = current;

      // If process is not null, process the current node
      if (current.value != null) process?.call(current);

      // If a predicate function is past, runs it agains the currentNode and returns appropriately
      if (predicate != null && predicate(current)) return currentNode;

      // Enqueue all children of the current node
      for (var child in current.children!) {
        queue.add(child);
      }
    }

    return null;
  }

  void rebuild(bool Function(T) predicate, {bool shouldResetTree = false}) {
    List<Node<NodeData<T>>> nodes = [];

    if (shouldResetTree) _resetTree();

    bfsTraversal(
      process: (node) {
        final extractedData = node.value?.data;

        if (extractedData != null && predicate(extractedData)) {
          nodes.add(node);
        }
      },
      startNoode: _tree,
    );

    List<NodePath> pathsToEachNode = _nodePathList(nodes);

    if (pathsToEachNode.isEmpty) _updateTree(_emptyTree);

    Node<NodeData<T>> newTree = _tree.copyWith(children: [], expanded: true);

    for (final path in pathsToEachNode) {
      if (path.isNotEmpty) {
        if (path.length == 1) {
          newTree = _addNodeImmediateChildren(
            predicate: predicate,
            rootNode: newTree,
            path: path,
          );
        } else {
          newTree = _addNestedNodes(
            predicate: predicate,
            rootNode: newTree,
            path: path,
          );
        }
      }
    }

    _updateTree(newTree);
  }

  Node<NodeData<T>>? _findNodeByPath(NodePath ids) {
    Node<NodeData<T>> current = _tree;

    // Traverse until the second-to-last id to find the parent
    for (int i = 0; i < ids.length; i++) {
      int id = ids[i];

      if (id >= current.children!.length) return null;
      current = current.children![id];
    }

    return current;
  }

  List<NodePath> _nodePathList(List<Node<NodeData<T>>> nodes) {
    return nodes
        .map((node) => _tree.nodePath((innerNode) => innerNode.id == node.id))
        .toList();
  }

  Node<NodeData<T>> _addNodeImmediateChildren({
    required bool Function(T) predicate,
    required Node<NodeData<T>> rootNode,
    required NodePath path,
  }) {
    final currentChildren = rootNode.children;
    Node<NodeData<T>>? newChildren = _findNodeByPath(path);

    newChildren ??= _tree.children!.elementAt(path.last);

    newChildren = newChildren.copyWith(
      expanded: true,
      children: [],
    );

    currentChildren!.addChild(
      newChildren,
      position: path.last,
    );
    rootNode.copyWith(children: currentChildren);
    return rootNode;
  }

  Node<NodeData<T>> _addNestedNodes({
    required bool Function(T) predicate,
    required Node<NodeData<T>> rootNode,
    required NodePath path,
  }) {
    Node<NodeData<T>> currentNode = rootNode;

    for (int i = 0; i < path.length; i++) {
      final childPosition = path[i];

      final nodeFoundByPath = _findNodeByPath(path.sublist(0, i + 1))!;
      final Node<NodeData<T>> node = nodeFoundByPath.copyWith(
        expanded: true,
        children: [],
      );

      if (node.parent?.id == currentNode.id) {
        currentNode.children!.addChild(node, position: childPosition);

        if (childPosition < currentNode.children!.length) {
          currentNode = currentNode.children![childPosition];
        } else {
          final containsRecord = currentNode.children!.containsChild(node);
          final indexInserted = containsRecord.$3;
          final inserted = containsRecord.$1;

          if (inserted) {
            currentNode = currentNode.children![indexInserted!];
          }
        }
      }
    }

    return rootNode;
  }
}
