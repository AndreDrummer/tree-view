import 'package:flutter/material.dart';
import 'package:tree_view/data/person.dart';
import 'package:tree_view/models/person.dart';

class Controller with ChangeNotifier {
  static final Person _originalRoot = tree;

  static Person _root = _originalRoot;

  Person get root => _root;

  void _setRoot(Person node) {
    _root = node;
  }

  PersonGender genderTypeFilter = PersonGender.none;
  PersonGender get female => PersonGender.female;
  PersonGender get male => PersonGender.male;
  PersonGender get none => PersonGender.none;

  void toogleNodeView(Person node) {
    final updatedNode = node.expanded ? node.close() : node.open();

    bool nodeWithIdPredicate(Person innerNode) {
      return innerNode.id == node.id;
    }

    final newNode = root.toggleNode(updatedNode, nodeWithIdPredicate);

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
    final newNode = root.buildTreeWithPredicate(
      (person) {
        return person.gender == genderTypeFilter;
      },
    );
    _setRoot(newNode ?? root);

    notifyListeners();
  }
}
