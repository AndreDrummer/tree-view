import 'package:tree_view/data/mount_tree.dart';
import 'package:tree_view/models/person.dart';
import 'package:tree_view/core/node/node.dart';
import 'package:flutter/material.dart';

class Controller with ChangeNotifier {
  static final Node<Person> _originalRoot = nodeRoot();

  static Node<Person> _root = _originalRoot;

  Node<Person> get root => _root;

  void _setRoot(Node<Person> node) {
    _root = node;
  }

  PersonGender genderTypeFilter = PersonGender.none;
  PersonGender get female => PersonGender.female;
  PersonGender get male => PersonGender.male;
  PersonGender get none => PersonGender.none;

  void toogleNodeView(Node<Person> node) {
    final updatedNode = node.expanded ? node.close() : node.open();

    final newNode = root.toggleNode(updatedNode);

    if (node.id == root.id) _setRoot(newNode ?? root);

    notifyListeners();
  }

  void filterByMaleGender() {
    _setRoot(_originalRoot);

    if (genderTypeFilter == male) {
      genderTypeFilter = none;

      notifyListeners();
    } else {
      genderTypeFilter = male;
      _filterByGender();
    }
  }

  void filterByFemaleGender() {
    _setRoot(_originalRoot);

    if (genderTypeFilter == female) {
      genderTypeFilter = none;

      notifyListeners();
    } else {
      genderTypeFilter = female;
      _filterByGender();
    }
  }

  void _filterByGender() {
    final newNode = root.rebuildTree(
      (node) {
        return node.data.gender == genderTypeFilter;
      },
    );
    _setRoot(newNode ?? root);

    notifyListeners();
  }
}
