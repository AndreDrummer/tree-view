import 'package:flutter/foundation.dart';
import 'package:tree_view/shared/simple_tree/models/node_data.dart';
import 'package:tree_view/shared/simple_tree/models/parent.dart';
import 'package:tree_view/shared/simple_tree/node.dart';
import 'dart:collection';

import 'package:tree_view/shared/simple_tree/utils/extensions.dart';

class TreeManager<T extends Parent> {
  TreeManager._(this._dataList) {
    _treeRoot = _referenceTree();
    debugPrint("Init the tree... $_treeRoot");
  }

  // Is is changed constantly to reflect the data dynamicity.
  final List<T> _dataList;

  static TreeManager instance<T extends Parent>(List<T> dataList) {
    return TreeManager._(dataList);
  }

  /// This is representation of a empty tree.
  final Node<NodeData<T>> _emptyTree = Node<NodeData<T>>(id: -1);

  late Node<NodeData<T>> _treeRoot;

  Node<NodeData<T>> get treeRoot => _treeRoot;

  bool get treeIsNotEmpty => _treeRoot.id != _emptyTree.id;

  void _updateTree(Node<NodeData<T>> node) {
    _treeRoot = node;
  }

  void _resetTree() {
    _treeRoot = _referenceTree();
  }

  /// This is the initial tree mounted. It never changes.
  Node<NodeData<T>> _referenceTree() {
    final List<NodeData<T>> nodeDataList = _dataList.toNodeDataList();

    print(nodeDataList);

    final Node<NodeData<T>> nodeRoot = Node(
      value: NodeData<T>(data: _dataList.first, id: 0),
      id: 0,
    );

    for (final nodeData in nodeDataList) {
      Node<NodeData<T>> node = Node<NodeData<T>>(
        id: nodeData.id,
        value: nodeData,
      );

      Node<NodeData<T>>? nodeParent = bfsTraversal(
        rootNode: nodeRoot,
        predicate: (innerNode) {
          return innerNode.value?.data.id == nodeData.data.parentId;
        },
      );

      if (nodeParent != null) {
        nodeParent.children!.addChild(node);
        node.parent = nodeParent;
      }
    }

    return nodeRoot;
  }

  void toogleNodeView(Node<NodeData<T>> node, {bool shouldResetTree = false}) {
    if (shouldResetTree) _resetTree();

    final updatedNode = node.expanded ? node.close() : node.open();

    final newNode = treeRoot.toggleNode(updatedNode);

    if (node.id == treeRoot.id) _updateTree(newNode ?? _emptyTree);
  }

  Node<NodeData<T>>? bfsTraversal({
    bool Function(Node<NodeData<T>>)? predicate,
    // TODO: Verify the necesity of this param.
    required Node<NodeData<T>> rootNode,
    void Function(Node<NodeData<T>>)? process,
  }) {
    // Initialize a queue and add the root node
    Queue<Node<NodeData<T>>> queue = Queue<Node<NodeData<T>>>();
    Node<NodeData<T>> currentNode = rootNode;
    queue.add(rootNode);

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

    bfsTraversal(
      process: (node) {
        final extractedData = node.value?.data;

        if (extractedData != null && predicate(extractedData)) {
          nodes.add(node);
        }
      },
      rootNode: _treeRoot,
    );

    List<NodePath> pathsToEachNode = _nodePathList(nodes);

    if (pathsToEachNode.isEmpty) _updateTree(_emptyTree);

    Node<NodeData<T>> newTree = _treeRoot.copyWith(
      expanded: true,
      children: [],
    );

    for (final path in pathsToEachNode) {
      if (path.isNotEmpty) {
        if (path.length == 1) {
          newTree = _addNodeImmediateChildren(newTree, path);
        } else {
          newTree = _addNestedNodes(newTree, path);
        }
      }
    }

    _updateTree(newTree);
  }

  Node<NodeData<T>>? _findNodeByPath(NodePath ids) {
    Node<NodeData<T>> current = _treeRoot;

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
        .map((node) =>
            _treeRoot.nodePath((innerNode) => innerNode.id == node.id))
        .toList();
  }

  Node<NodeData<T>> _addNodeImmediateChildren(
      Node<NodeData<T>> rootNode, NodePath path) {
    final currentChildren = rootNode.children;
    Node<NodeData<T>>? newChildren = _findNodeByPath(path);

    newChildren ??= _treeRoot.children!.elementAt(path.last);

    newChildren = newChildren.copyWith(
      children: [],
      expanded: true,
    );

    currentChildren!.addChild(
      newChildren,
      position: path.last,
    );
    rootNode.copyWith(children: currentChildren);
    return rootNode;
  }

  Node<NodeData<T>> _addNestedNodes(Node<NodeData<T>> rootNode, NodePath path) {
    Node<NodeData<T>> currentNode = rootNode;

    for (int i = 0; i < path.length; i++) {
      final childPosition = path[i];

      final Node<NodeData<T>> node = _findNodeByPath(path.sublist(0, i + 1))!
          .copyWith(children: [], expanded: true);

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
