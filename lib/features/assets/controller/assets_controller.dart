import 'package:tree_view/core/utils/extensions.dart';
import 'package:tree_view/core/models/person.dart';
import 'package:tree_view/core/data/person.dart';
import 'package:flutter/material.dart';

typedef Predicate<Person> = bool Function(Person item);

enum FilterType {
  gender,
  text,
}

class AssetsController with ChangeNotifier {
  static List<Person> _data = dataPerson;

  List<Person> get data => _data;

  void resetData() {
    _data = dataPerson;
    notifyListeners();
  }

  bool _isFilteringByText = false;
  String _textToSearch = "";
  String get textToSearch => _textToSearch;

  bool get resetDataOnFilter => false;

  PersonGender genderTypeFilter = PersonGender.none;
  PersonGender get female => PersonGender.female;
  PersonGender get male => PersonGender.male;
  PersonGender get none => PersonGender.none;

  bool get isFilteringByAny {
    return genderTypeFilter != none || _isFilteringByText;
  }

  Map<FilterType, Predicate<Person>> _predicateList = {};

  bool Function(Person) get filterPredicate {
    return (Person item) {
      // Combine all predicates using AND logic
      for (var predicate in _predicateList.entries) {
        if (!predicate.value(item)) {
          return false; // If any predicate returns false, the result is false
        }
      }
      return true; // All predicates passed
    };
  }

  void _resetPredicates() {
    _predicateList = {};
  }

  void setSearchText(String text) {
    _textToSearch = text;
    searchByText();
  }

  void _clearSearchText() {
    _textToSearch = "";
  }

  void searchByText() {
    final String finalText = textToSearch.removeAccents().trim().toLowerCase();

    if (finalText.length >= 3) {
      _isFilteringByText = true;

      bool predicate(Person person) {
        final nameToCompare = person.name.removeAccents().trim().toLowerCase();
        return nameToCompare.contains(finalText);
      }

      _predicateList.putIfAbsent(FilterType.text, () => predicate);
    } else {
      _isFilteringByText = false;
      _predicateList.removeWhere((k, v) => k == FilterType.text);
    }

    notifyListeners();
  }

  void _filterByGender() {
    _clearSearchText();

    if (genderTypeFilter == none) {
      _predicateList.removeWhere((k, v) => k == FilterType.gender);
    } else {
      bool predicate(Person person) => person.gender == genderTypeFilter;
      _predicateList.putIfAbsent(FilterType.gender, () => predicate);
    }

    notifyListeners();
  }

  void filterByMaleGender() {
    if (genderTypeFilter == male) {
      genderTypeFilter = none;
    } else {
      genderTypeFilter = male;
    }
    _filterByGender();
  }

  void filterByFemaleGender() {
    if (genderTypeFilter == female) {
      genderTypeFilter = none;
    } else {
      genderTypeFilter = female;
    }
    _filterByGender();
  }
}
