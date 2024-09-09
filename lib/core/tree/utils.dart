import 'package:tree_view/core/tree/node.dart';
import 'dart:collection';

class TreeUtils<T extends TOString> {
  TreeUtils._(this._root);

  static TreeUtils<T> instance<T extends TOString>(Node<T> root) {
    return TreeUtils._(root);
  }

  final Node<T> _root;

  Node<T>? bfsTraversal({
    bool Function(Node<T>)? predicate,
    void Function(dynamic)? process,
    required Node<T> rootNode,
  }) {
    // Initialize a queue and add the root node
    Queue<Node<T>> queue = Queue<Node<T>>();
    Node<T> currentNode = rootNode;
    queue.add(rootNode);

    // Traverse while there are nodes in the queue
    while (queue.isNotEmpty) {
      // Dequeue the front node
      Node<T> current = queue.removeFirst();
      currentNode = current;

      // If process is not null, process the current node
      process?.call(current);

      // If a predicate function is past, runs it agains the currentNode and returns appropriately
      if (predicate != null && predicate(current)) return currentNode;

      // Enqueue all children of the current node
      for (var child in current.children!) {
        queue.add(child);
      }
    }

    return null;
  }

  Node<T>? rebuild(bool Function(Node<T>) predicate) {
    List<Node<T>> nodes = [];

    bfsTraversal(
      process: (node) {
        if (predicate(node)) {
          nodes.add(node);
        }
      },
      rootNode: _root,
    );

    List<NodePath> pathsToEachNode = _nodePathList(nodes);

    if (pathsToEachNode.isEmpty) return null;

    Node<T> newTree = _root.copyWith(
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

    return newTree;
  }

  Node<T>? _findNodeByPath(NodePath ids) {
    Node<T> current = _root;

    // Traverse until the second-to-last id to find the parent
    for (int i = 0; i < ids.length; i++) {
      int id = ids[i];

      if (id >= current.children!.length) return null;
      current = current.children![id];
    }

    return current;
  }

  List<NodePath> _nodePathList(List<Node<T>> nodes) {
    return nodes
        .map((node) => _root.nodePath((innerNode) => innerNode.id == node.id))
        .toList();
  }

  Node<T> _addNodeImmediateChildren(Node<T> rootNode, NodePath path) {
    final currentChildren = rootNode.children;
    Node<T>? newChildren = _findNodeByPath(path);

    newChildren ??= _root.children!.elementAt(path.last);

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

  Node<T> _addNestedNodes(Node<T> rootNode, NodePath path) {
    Node<T> currentNode = rootNode;

    for (int i = 0; i < path.length; i++) {
      final childPosition = path[i];

      final Node<T> node = _findNodeByPath(path.sublist(0, i + 1))!
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
