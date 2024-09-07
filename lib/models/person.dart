import 'dart:collection';

enum PersonGender { female, male, none }

typedef NodePath = List<int>;

class Person {
  List<Person> children;
  PersonGender gender;
  bool expanded;
  String name;
  int id;

  Person({
    this.gender = PersonGender.male,
    this.children = const [],
    this.expanded = false,
    required this.name,
    required this.id,
  });

  bool get hasChildren => children.isNotEmpty;
  int get numberOfChildren => children.length;

  int get descendents {
    int value = children.length;

    if (children.isNotEmpty) {
      for (var c in children) {
        int a = c.descendents;

        value += a;
      }
    }

    return value;
  }

  bool get hasExpandedChildren {
    for (var c in children) {
      if (c.expanded) {
        return true;
      }
    }

    return false;
  }

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

  int get numberOfDescendentsShowingUpOfDescendents {
    int value = 0;

    if (children.isNotEmpty) {
      for (var c in children) {
        if (c.expanded) {
          value += c.numberOfDescendentsShowingUp;
        }
      }
    }

    return value;
  }

  Person close() {
    return _copyWith(
      children: children.map((c) => c.close()).toList(),
      expanded: false,
    );
  }

  Person open() {
    return _copyWith(
      children: children,
      expanded: true,
    );
  }

  Person? toggleNode(Person node, bool Function(Person) predicate) {
    // Find the parent of the target family member
    List<int> nodePath = _nodePath(predicate);
    Person? parent = _findParent(nodePath);

    // This is the condition that check if I'm on the root node
    if (parent != null && nodePath.isNotEmpty) {
      int nodeToBeRemovedID = nodePath.last;

      parent.children[nodeToBeRemovedID] = node;
    } else {
      return node;
    }

    return parent;
  }

  Person? buildTreeWithPredicate(bool Function(Person) predicate) {
    List<Person> nodes = [];

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

    Person newTree = _copyWith(
      name: name,
      id: id,
      gender: gender,
      expanded: true,
      children: [],
    );

    for (final path in pathsToEachNode) {
      if (path.isNotEmpty) {
        if (path.length == 1) {
          final currentChildren = newTree.children;
          Person? newChildren = _findNodeByPath(path);

          newChildren ??= children.elementAt(path.last);

          newChildren = newChildren._copyWith(
            children: [],
            expanded: true,
          );

          currentChildren.addChild(
            newChildren,
            position: path.last,
          );
          newTree._copyWith(children: currentChildren);
        } else {
          newTree = _addNestedNodes(newTree, path);
        }
      }
    }
    return newTree;
  }

  Person _addNestedNodes(Person rootNode, NodePath path) {
    // [1, 1, 0, 2]
    // root.children[1] =
    // root.children[1].children[1] =
    // root.children[1].children[1].children[0] =
    // root.children[1].children[1].children[0].children[2] =

    Person currentNode = rootNode;

    for (int i = 0; i < path.length; i++) {
      final childPosition = path[i];

      final Person node = _findNodeByPath(path.sublist(0, i + 1))!
          ._copyWith(children: [], expanded: true);

      print(currentNode.name);

      print(
          "${node.name} $childPosition ${currentNode.children.length} Path $path $i PathLength: ${path.length}");
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

  Person _copyWith({
    List<Person>? children,
    PersonGender? gender,
    bool? expanded,
    String? name,
    int? id,
  }) {
    return Person(
      children: children ?? this.children,
      expanded: expanded ?? this.expanded,
      gender: gender ?? this.gender,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  List<int> _nodePath(bool Function(Person) predicate, {Person? node}) {
    List<int> idList =
        _convertMapPathToIDListPath(_findPath(predicate, root: node) ?? {});

    return _convertIDListToPosList(idList, rootNode: node);
  }

  Person? _findParent(NodePath ids, {Person? rootNode}) {
    Person? current = rootNode ?? this;

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

  Person? _findNodeByPath(NodePath ids, {Person? rootNode}) {
    Person current = rootNode ?? this;

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
    bool Function(Person) predicate, {
    Person? root,
    Map<String, int>? map,
  }) {
    Person startNode = root ?? this;

    // Initialize the path if not set
    map ??= {startNode.name: startNode.id};

    // If the current person is the target, return the path
    if (predicate(startNode)) {
      return map;
    }

    // Recursively search through each child
    for (Person child in (this).children) {
      map.putIfAbsent(child.name, () => child.id);
      Map<String, int>? result = child._findPath(predicate, map: map);
      if (result != null) {
        return result; // Return if the path is found
      }

      // Backtrack if not found in the current branch
      map.removeWhere((k, v) => v == child.id);
    }

    return null; // Return null if no path found
  }

  List<int> _convertIDListToPosList(List<int> ids, {Person? rootNode}) {
    Person currentNode = this;
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
    required Person rootNode,
  }) {
    // Initialize a queue and add the root node
    Queue<Person> queue = Queue<Person>();
    queue.add(rootNode);

    // Traverse while there are nodes in the queue
    while (queue.isNotEmpty) {
      // Dequeue the front node
      Person current = queue.removeFirst();

      // Process the current node (e.g., print its value)
      process(current);

      // Enqueue all children of the current node
      for (var child in current.children) {
        queue.add(child);
      }
    }
  }

  @override
  String toString() {
    return '''
    children: ${children.map((c) => c.name).toList()},
    expanded: $expanded,
    gender: $gender,
    name: $name,
    id: $id,      
    ''';
  }
}

extension ListPerson on List<Person> {
  void addChild(Person child, {int? position}) {
    final contains = containsChild(child);

    if (!contains.$1) {
      (position == null || length < position)
          ? add(child)
          : insert(position, child);
    } else {
      // remove(contains.$2!);

      // addChild(child, position: position);
    }
  }

  (bool, Person?) containsChild(Person child) {
    (bool, Person?) contains = (false, null);

    for (final c in this) {
      if (c.id == child.id) return (true, c);
    }

    return contains;
  }
}
