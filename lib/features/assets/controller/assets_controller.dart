import 'package:tree_view/core/models/person.dart';
import 'package:tree_view/core/tree/init.dart';
import 'package:tree_view/core/tree/node.dart';
import 'package:flutter/material.dart';
import 'package:tree_view/core/utils/extensions.dart';

class AssetsController with ChangeNotifier {
  static final Node<Person> _emptyNode = Node<Person>(id: -1);
  static final Node<Person> _originalRoot = nodeRoot();

  bool _scrollToTheEndOfData = false;

  bool get scrollToTheEndOfData => _scrollToTheEndOfData;

  static Node<Person> _root = _originalRoot;

  Node<Person> get root => _root;

  void _setRoot(Node<Person> node) {
    _root = node;
  }

  PersonGender genderTypeFilter = PersonGender.none;
  PersonGender get female => PersonGender.female;
  PersonGender get male => PersonGender.male;
  PersonGender get none => PersonGender.none;

  bool _isFilteringByText = false;

  bool get isFilteringByAny {
    return genderTypeFilter != none || _isFilteringByText;
  }

  void toogleNodeView(Node<Person> node) {
    if (_isFilteringByText) _setRoot(_originalRoot);

    final updatedNode = node.expanded ? node.close() : node.open();

    final newNode = root.toggleNode(updatedNode);

    if (node.id == root.id) _setRoot(newNode ?? _emptyNode);

    notifyListeners();
  }

  void searchByText(String text) {
    final String textToSearch = text.removeAccents().trim().toLowerCase();
    debugPrint(textToSearch);

    if (textToSearch.length >= 3) {
      _isFilteringByText = true;
      final newNode = root.rebuildTree(
        (node) {
          final nodeDataNameToCompare =
              node.data?.name.removeAccents().trim().toLowerCase();
          return nodeDataNameToCompare?.contains(textToSearch) ?? false;
        },
      );
      _setRoot(newNode ?? _emptyNode);
    } else {
      _isFilteringByText = false;
      _setRoot(_originalRoot);
    }

    notifyListeners();
  }

  void filterByMaleGender() {
    _setRoot(_originalRoot);

    if (genderTypeFilter == male) {
      _scrollToTheEndOfData = false;
      genderTypeFilter = none;

      notifyListeners();
    } else {
      _scrollToTheEndOfData = true;
      genderTypeFilter = male;
      _filterByGender();
    }
  }

  void filterByFemaleGender() {
    _setRoot(_originalRoot);

    if (genderTypeFilter == female) {
      _scrollToTheEndOfData = false;
      genderTypeFilter = none;

      notifyListeners();
    } else {
      _scrollToTheEndOfData = true;
      genderTypeFilter = female;
      _filterByGender();
    }
  }

  void _filterByGender() {
    _scrollToTheEndOfData = true;

    final newNode = root.rebuildTree(
      (node) {
        return node.data?.gender == genderTypeFilter;
      },
    );
    _setRoot(newNode ?? _emptyNode);

    notifyListeners();
  }
}
