import 'package:tree_view/core/data/person.dart';
import 'package:tree_view/core/utils/extensions.dart';
import 'package:tree_view/core/models/person.dart';
import 'package:flutter/material.dart';

class AssetsController with ChangeNotifier {
  final List<Person> data = dataPerson;

  bool get scrollToTheEndOfData => _scrollToTheEndOfData;

  bool _scrollToTheEndOfData = false;

  PersonGender genderTypeFilter = PersonGender.none;
  PersonGender get female => PersonGender.female;
  PersonGender get male => PersonGender.male;
  PersonGender get none => PersonGender.none;

  bool _isFilteringByText = false;

  bool get isFilteringByAny {
    return genderTypeFilter != none || _isFilteringByText;
  }

  void searchByText(String text) {
    final String textToSearch = text.removeAccents().trim().toLowerCase();

    if (textToSearch.length >= 3) {
      _isFilteringByText = true;

      bool predicate(Person person) {
        final nameToCompare = person.name.removeAccents().trim().toLowerCase();
        return nameToCompare.contains(textToSearch);
      }

      // _treeInstance.rebuild(predicate);
    } else {
      _isFilteringByText = false;
    }

    notifyListeners();
  }

  void filterByMaleGender() {
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

    bool predicate(Person person) {
      return person.gender == genderTypeFilter;
    }

    // _treeInstance.rebuild(predicate, shouldResetTree: true);

    notifyListeners();
  }
}
