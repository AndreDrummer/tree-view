enum PeronGender { female, male }

class Person {
  List<Person> children;
  PeronGender gender;
  bool expanded;
  String name;

  Person({
    this.gender = PeronGender.male,
    this.children = const [],
    this.expanded = false,
    required this.name,
  });

  bool hasChildren() => children.isNotEmpty;
  int numberOfChildren() => children.length;

  int descendents() {
    int value = children.length;

    if (children.isNotEmpty) {
      for (var c in children) {
        int a = c.descendents();

        value += a;
      }
    }

    return value;
  }

  bool hasExpandedChildren() {
    for (var c in children) {
      if (c.expanded) {
        return true;
      }
    }

    return false;
  }

  int numberOfDescendentsShowingUp() {
    int value = expanded ? numberOfChildren() : 0;

    if (hasChildren()) {
      for (var child in children) {
        if (child.expanded) {
          value += child.numberOfDescendentsShowingUp();
        }
      }
    }

    return value;
  }

  int numberOfDescendentsShowingUpOfDescendents() {
    int value = 0;

    if (children.isNotEmpty) {
      for (var c in children) {
        if (c.expanded) {
          value += c.numberOfDescendentsShowingUp();
        }
      }
    }

    return value;
  }

  Person closeNode() => _copyWith(expanded: false);

  Person _copyWith({
    List<Person>? children,
    bool? expanded,
    String? name,
  }) {
    return Person(
      children: children ?? this.children,
      expanded: expanded ?? this.expanded,
      name: name ?? this.name,
    );
  }
}
