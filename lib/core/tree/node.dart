import 'package:tree_view/core/tree/utils.dart';

typedef NodePath = List<int>;

abstract class TOString {
  @override
  String toString();
}

class Node<T extends TOString> {
  List<Node<T>>? children;
  Node<T>? parent;
  bool expanded;
  int id;
  T data;

  Node({
    this.expanded = false,
    required this.data,
    required this.id,
    this.children,
    this.parent,
  }) {
    children ??= [];
  }

  @override
  String toString() {
    return '''
      children: ${children!.map((e) => e.data.toString())}
      parent: ${parent?.id}
      data: ${data.toString()}
      expanded: $expanded
      id: $id
    ''';
  }

  bool _findNodeByIdPredicate(Node innerNode, Node currentNode) {
    return innerNode.id == currentNode.id;
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

  int get getHeightUntilRoot {
    int height = 0;
    Node? current = this;

    while (current?.parent != null) {
      height++;
      current = current?.parent;
    }

    return height;
  }

  Node<T>? toggleNode(Node<T> updatedNode) {
    List<int> nodePath = _nodePath(
      (node) {
        return _findNodeByIdPredicate(node, updatedNode);
      },
    );

    Node<T>? parent = _findParent(nodePath);

    if (parent != null && nodePath.isNotEmpty) {
      int nodeIndex = nodePath.last;

      parent.children![nodeIndex] = updatedNode;
    } else {
      return updatedNode;
    }

    return parent;
  }

  Node<T>? rebuildTree(bool Function(Node<T>) predicate) {
    List<Node<T>> nodes = [];

    TreeUtils.bfsTraversal<T>(
      process: (node) {
        if (predicate(node)) {
          nodes.add(node);
        }
      },
      rootNode: this,
    );

    List<List<int>> pathsToEachNode = nodes
        .map((node) => _nodePath((innerNode) => innerNode.id == node.id))
        .toList();

    print("pathsToEachNode $pathsToEachNode");
    Node<T> newTree = copyWith(
      expanded: true,
      children: [],
    );

    for (final path in pathsToEachNode) {
      if (path.isNotEmpty) {
        if (path.length == 1) {
          final currentChildren = newTree.children;
          Node<T>? newChildren = _findNodeByPath(path);

          newChildren ??= children!.elementAt(path.last);

          newChildren = newChildren.copyWith(
            children: [],
            expanded: true,
          );

          currentChildren!.addChild(
            newChildren,
            position: path.last,
          );
          newTree.copyWith(children: currentChildren);
        } else {
          newTree = _addNestedNodes(newTree, path);
        }
      }
    }
    return newTree;
  }

  Node<T> copyWith({
    List<Node<T>>? children,
    bool? expanded,
    int? id,
    T? data,
  }) {
    return Node<T>(
      children: children ?? this.children,
      expanded: expanded ?? this.expanded,
      data: data ?? this.data,
      id: id ?? this.id,
      parent: parent,
    );
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

  List<int> _nodePath(bool Function(Node<T>) predicate) {
    List<int> idList = _findPath(predicate) ?? [];

    // skip the root node
    return _convertIDListToPosList(idList.sublist(1));
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
          return null; // Parent not found
        }
        current = current.children![id];
      }

      return current;
    }

    return null;
  }

  Node<T>? _findNodeByPath(NodePath ids, {Node<T>? rootNode}) {
    Node<T> current = rootNode ?? this;

    // Traverse until the second-to-last id to find the parent
    for (int i = 0; i < ids.length; i++) {
      int id = ids[i];

      if (id >= current.children!.length) return null;
      current = current.children![id];
    }

    return current;
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
}

extension ListInt on List<int> {
  void addIfAbsent(int intValue) {
    if (!contains(intValue)) {
      add(intValue);
    }
  }
}

extension ListNode<T extends TOString> on List<Node<T>> {
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
