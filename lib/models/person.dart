import 'dart:collection';

enum PeronGender { female, male }

class Person {
  List<Person> children;
  PeronGender gender;
  bool expanded;
  String name;
  int id;

  Person({
    this.gender = PeronGender.male,
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

  Person toogleNodeView() => _copyWith(expanded: !expanded);

  Person _copyWith({
    List<Person>? children,
    bool? expanded,
    String? name,
  }) {
    return Person(
      children: children ?? this.children,
      expanded: expanded ?? this.expanded,
      name: name ?? this.name,
      id: id,
    );
  }

  Person? updateNode(Person newNode) {
    // Find the parent of the target family member
    List<int> nodePath = _nodePath(newNode.id);
    Person? parent = _findParent(nodePath);

    // This is the condition that check if I'm on the root node
    if (parent != null && nodePath.isNotEmpty) {
      removeNode(nodePath);
      parent.children.add(newNode);
      print('Added sibling: ${newNode.name} to parent ${parent.name}');
    } else {
      print('Parent not found. Unable to add sibling.');
      return newNode;
    }

    return parent;
  }

  void removeNode(List<int> nodePath) {
    int nodeToBeRemovedID = nodePath.last;

    // Find the parent of the target family member
    Person? parent = _findParent(nodePath);
    print("nodePath $nodePath");

    if (parent != null) {
      // Add the new sibling to the parent's children list
      parent.children.removeAt(nodeToBeRemovedID);
      print(
          'Node ${parent.children.elementAt(nodeToBeRemovedID)} son of ${parent.name} removed');
    } else {
      print('Parent not found. Unable to remove node.');
    }
  }

  List<int> _nodePath(int id) {
    List<int> idList = _convertMapPathToIDListPath(_findPath(id) ?? {});
    return _convertIDListToPosList(idList);
  }

  Person? _findParent(List<int> ids) {
    Person? current = this;

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

  List<int> _convertMapPathToIDListPath(Map<String, int> map) {
    return map.entries.skip(1).toList().map((entry) {
      return entry.value;
    }).toList();
  }

  // DFS function to find the path from start to target
  Map<String, int>? _findPath(int id, [Map<String, int>? path]) {
    // Initialize the path if not set
    path ??= {(this).name: (this).id};

    // If the current person is the target, return the path
    if ((this).id == id) {
      return path;
    }

    // Recursively search through each child
    for (Person child in (this).children) {
      path.putIfAbsent(child.name, () => child.id);
      Map<String, int>? result = child._findPath(id, path);
      if (result != null) {
        return result; // Return if the path is found
      }

      // Backtrack if not found in the current branch
      path.removeWhere((k, v) => v == child.id);
    }

    return null; // Return null if no path found
  }

  List<int> _convertIDListToPosList(List<int> ids) {
    Person currentNode = this;
    List<int> pos = [];

    print("IDS $ids");

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
