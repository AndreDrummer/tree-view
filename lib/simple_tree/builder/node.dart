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
  bool get isNotEmpty => id >= 0;
  bool get isEmpty => id == -1;

  int get getHeightFromNodeToRoot {
    int height = 0;
    Node? current = this;

    while (current?.parent != null) {
      height++;
      current = current?.parent;
    }

    return height;
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
