import 'dart:collection';

typedef NodePath = List<int>;

abstract class NodeCompliance {
  abstract String name;
}

class Node<T extends NodeCompliance> {
  List<Node<T>> children;
  bool expanded;
  int id;
  T data;

  Node({
    this.children = const [],
    this.expanded = false,
    required this.data,
    required this.id,
  });

  bool get hasChildren => children.isNotEmpty;
  int get numberOfChildren => children.length;

  int get numberOfDescendentsShowingUp {
    int value = expanded ? numberOfChildren : 0;

    if (hasChildren) {
      for (var child in children) {
        if (child.expanded) {
          value += child.numberOfDescendentsShowingUp;
        }
      }
    }

    return value;
  }

  Node<T> close() {
    return copyWith(
      children: children.map((c) => c.close()).toList(),
      expanded: false,
    );
  }

  Node<T> open() {
    return copyWith(
      children: children,
      expanded: true,
    );
  }

  Node<T>? toggleNode(Node<T> updatedNode, bool Function(Node<T>) predicate) {
    List<int> nodePath = _nodePath(predicate);
    Node<T>? parent = _findParent(nodePath);

    if (parent != null && nodePath.isNotEmpty) {
      int nodeIndex = nodePath.last;

      parent.children[nodeIndex] = updatedNode;
    } else {
      return updatedNode;
    }

    return parent;
  }

  Node<T>? buildTreeWithPredicate(bool Function(Node<T>) predicate) {
    List<Node<T>> nodes = [];

    bfsTraversal(
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

    // print("NODE ${nodes.length} $nodes");
    print("NODE PATHS ${pathsToEachNode.length} $pathsToEachNode");

    Node<T> newTree = copyWith(
      expanded: true,
      children: [],
    );

    for (final path in pathsToEachNode) {
      if (path.isNotEmpty) {
        if (path.length == 1) {
          final currentChildren = newTree.children;
          Node<T>? newChildren = _findNodeByPath(path);

          newChildren ??= children.elementAt(path.last);

          newChildren = newChildren.copyWith(
            children: [],
            expanded: true,
          );

          currentChildren.addChild(
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
    );
  }

  Node<T> _addNestedNodes(Node<T> rootNode, NodePath path) {
    // [1, 1, 0, 2]
    // root.children[1] =
    // root.children[1].children[1] =
    // root.children[1].children[1].children[0] =
    // root.children[1].children[1].children[0].children[2] =

    Node<T> currentNode = rootNode;

    for (int i = 0; i < path.length; i++) {
      final childPosition = path[i];

      final Node<T> node = _findNodeByPath(path.sublist(0, i + 1))!
          .copyWith(children: [], expanded: true);

      print(currentNode.data.name);

      print(
          "${node.data.name} $childPosition ${currentNode.children.length} Path $path $i PathLength: ${path.length}");
      if (childPosition < currentNode.children.length) {
        currentNode.children.addChild(node, position: childPosition);

        currentNode = currentNode.children[childPosition];
      } else {
        currentNode.children.addChild(node, position: childPosition);
        if (childPosition < currentNode.children.length) {
          currentNode = currentNode.children[childPosition];
        } else if (childPosition <= currentNode.children.length) {
          currentNode = currentNode.children[childPosition - 1];
        }
      }
    }

    return rootNode;
  }

  List<int> _nodePath(bool Function(Node<T>) predicate, {Node<T>? node}) {
    List<int> idList =
        _convertMapPathToIDListPath(_findPath(predicate, root: node) ?? {});

    return _convertIDListToPosList(idList, rootNode: node);
  }

  Node<T>? _findParent(NodePath ids, {Node<T>? rootNode}) {
    Node<T>? current = rootNode ?? this;

    // Traverse until the second-to-last id to find the parent
    for (int i = 0; i < ids.length - 1; i++) {
      int id = ids[i];
      if (current == null || id >= current.children.length) {
        return null; // Parent not found
      }
      current = current.children[id];
    }

    return current;
  }

  Node<T>? _findNodeByPath(NodePath ids, {Node<T>? rootNode}) {
    Node<T> current = rootNode ?? this;

    // Traverse until the second-to-last id to find the parent
    for (int i = 0; i < ids.length; i++) {
      int id = ids[i];

      if (id >= current.children.length) return null;
      current = current.children[id];
    }

    return current;
  }

  NodePath _convertMapPathToIDListPath(Map<String, int> map) {
    return map.entries.skip(1).toList().map((entry) {
      return entry.value;
    }).toList();
  }

// DFS function to find the path from start to target
  Map<String, int>? _findPath(
    bool Function(Node<T>) predicate, {
    Node<T>? root,
    Map<String, int>? map,
  }) {
    Node<T> startNode = root ?? this;

    // Initialize the path if not set
    map ??= {startNode.data.name: startNode.id};

    // If the current Node<T> is the target, return the path
    if (predicate(startNode)) {
      return map;
    }

    // Recursively search through each child
    for (Node<T> child in (this).children) {
      map.putIfAbsent(child.data.name, () => child.id);
      Map<String, int>? result = child._findPath(predicate, map: map);
      if (result != null) {
        return result; // Return if the path is found
      }

      // Backtrack if not found in the current branch
      map.removeWhere((k, v) => v == child.id);
    }

    return null; // Return null if no path found
  }

  List<int> _convertIDListToPosList(List<int> ids, {Node<T>? rootNode}) {
    Node<T> currentNode = this;
    List<int> pos = [];

    for (final id in ids) {
      currentNode = currentNode.children.where((el) {
        if (el.id == id) {
          pos.add(currentNode.children.indexOf(el));
          return true;
        } else {
          return false;
        }
      }).toList()[0];
    }

    return pos;
  }

  void bfsTraversal({
    required dynamic Function(dynamic) process,
    required Node<T> rootNode,
  }) {
    // Initialize a queue and add the root node
    Queue<Node<T>> queue = Queue<Node<T>>();
    queue.add(rootNode);

    // Traverse while there are nodes in the queue
    while (queue.isNotEmpty) {
      // Dequeue the front node
      Node<T> current = queue.removeFirst();

      // Process the current node (e.g., print its value)
      process(current);

      // Enqueue all children of the current node
      for (var child in current.children) {
        queue.add(child);
      }
    }
  }
}

extension ListNode on List<Node> {
  void addChild(Node child, {int? position}) {
    final contains = containsChild(child);

    if (!contains.$1) {
      (position == null || length < position)
          ? add(child)
          : insert(position, child);
    }
  }

  (bool, Node?) containsChild(Node child) {
    (bool, Node?) contains = (false, null);

    for (final c in this) {
      if (c.id == child.id) return (true, c);
    }

    return contains;
  }
}
