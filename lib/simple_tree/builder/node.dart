import 'package:flutter/material.dart';

typedef NodePath = List<int>;

class Node<T> {
  List<Node<T>>? children;
  Node<T>? parent;
  bool expanded;
  T? value;
  Key? key;
  int id;

  Node({
    required this.expanded,
    required this.id,
    this.children,
    this.parent,
    this.value,
    this.key,
  }) {
    children ??= [];
  }

  bool get hasChildren => children!.isNotEmpty;
  int get numberOfChildren => children!.length;

  int get numberOfDescendentsShowingUp {
    int value = expanded ? numberOfChildren : 0;

    if (hasChildren) {
      for (var child in children!) {
        if (child.expanded) {
          value += child.numberOfDescendentsShowingUp;
        }
      }
    }

    return value;
  }

  int get getHeightFromNodeToRoot {
    int height = 0;
    Node? current = this;

    while (current?.parent != null) {
      height++;
      current = current?.parent;
    }

    return height;
  }

  int get getHeight {
    final Node rootNode = this;

    if (rootNode.children!.isEmpty) {
      // If a node has no children, it's a leaf node, so its height is 0.
      return 0;
    } else {
      // Compute the height of each child node and find the maximum.
      int maxHeight = 0;
      for (var child in rootNode.children!) {
        int childHeight = child.getHeight;
        if (childHeight > maxHeight) {
          maxHeight = childHeight;
        }
      }
      // The height of the current node is 1 (for the edge to its highest child)
      // plus the height of the highest child.
      return maxHeight + 1;
    }
  }

  bool _findNodeByIdPredicate(Node innerNode, Node currentNode) {
    return innerNode.id == currentNode.id;
  }

  Node<T> close() {
    return copyWith(
      children: children!.map((c) => c.close()).toList(),
      expanded: false,
    );
  }

  Node<T> open() {
    return copyWith(
      children: children,
      expanded: true,
    );
  }

  Node<T>? toggleNode(Node<T> updatedNode) {
    List<int> pathToNode = nodePath(
      (node) {
        return _findNodeByIdPredicate(node, updatedNode);
      },
    );

    Node<T>? parent = _findParent(pathToNode);

    if (parent != null && pathToNode.isNotEmpty) {
      int nodeIndex = pathToNode.last;

      parent.children![nodeIndex] = updatedNode;
    } else {
      return updatedNode;
    }

    return parent;
  }

  Node<T> copyWith({
    List<Node<T>>? children,
    bool? expanded,
    T? value,
    int? id,
  }) {
    return Node<T>(
      children: children ?? this.children,
      expanded: expanded ?? this.expanded,
      value: value ?? this.value,
      id: id ?? this.id,
      parent: parent,
    );
  }

  List<int> nodePath(bool Function(Node<T>) predicate) {
    List<int> idList = _findPath(predicate) ?? [];

    // skip the root node
    return _convertIDListToPosList(idList.sublist(1));
  }

  List<int> _convertIDListToPosList(List<int> ids) {
    Node<T> currentNode = this;
    List<int> pos = [];

    for (final id in ids) {
      currentNode = currentNode.children!.where((el) {
        if (el.id == id) {
          pos.add(currentNode.children!.indexOf(el));
          return true;
        } else {
          return false;
        }
      }).toList()[0];
    }

    return pos;
  }

  /// Why do not use the [parent] property?
  ///
  /// This property only holds the same data as the
  /// current node parent. It does not carry the
  /// state of the tree. So, if you use [parent]
  /// instead, the tree will not get updated properly.
  Node<T>? _findParent(NodePath nodePath) {
    Node<T>? current = this;

    // Traverse until the second-to-last id to find the parent
    if (nodePath.isNotEmpty) {
      for (int i = 0; i < nodePath.length - 1; i++) {
        int id = nodePath[i];
        if (current == null || id >= current.children!.length) {
          return null; // ParentProtocol not found
        }
        current = current.children![id];
      }

      return current;
    }

    return null;
  }

// DFS function to find the path from start to target
  List<int>? _findPath(
    bool Function(Node<T>) predicate, {
    List<int>? map,
  }) {
    Node<T> startNode = this;

    // Initialize the path if not set
    map ??= [startNode.id];

    // If the current Node<T> is the target, return the path
    if (predicate(startNode)) {
      return map;
    }

    // Recursively search through each child
    for (Node<T> child in (this).children!) {
      map.addIfAbsent(child.id);
      List<int>? result = child._findPath(predicate, map: map);
      if (result != null) {
        return result; // Return if the path is found
      }

      // Backtrack if not found in the current branch
      map.remove(child.id);
    }

    return null; // Return null if no path found
  }

  @override
  String toString() {
    return '''
      children: ${children!.map((e) => e.value.toString())}
      data: ${value.toString()}
      parent: ${parent?.id}
      expanded: $expanded
      id: $id
    ''';
  }
}

extension ListInt on List<int> {
  void addIfAbsent(int intValue) {
    if (!contains(intValue)) {
      add(intValue);
    }
  }
}

extension ListNode<T> on List<Node<T>> {
  void addChild(Node<T> child, {int? position}) {
    final contains = containsChild(child);

    if (!contains.$1) {
      (position == null || length < position)
          ? add(child)
          : insert(position, child);
    }
  }

  (bool, Node<T>?, int? index) containsChild(Node<T> child) {
    (bool, Node<T>?, int? index) contains = (false, null, -1);

    for (final c in this) {
      if (c.id == child.id) return (true, c, indexOf(c));
    }

    return contains;
  }
}
