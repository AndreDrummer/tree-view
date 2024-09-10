import 'package:tree_view/core/utils/extensions.dart';
import 'package:tree_view/core/models/person.dart';
import 'package:tree_view/core/data/person.dart';
import 'package:get/get.dart';

typedef Predicate<Person> = bool Function(Person item);

enum FilterType {
  gender,
  text,
}

class AssetsController extends GetxController {
  Rx<PersonGender> genderTypeFilter = PersonGender.none.obs;
  final RxList<Person> _data = dataPerson.obs;
  final RxString _textToSearch = "".obs;

  // Getters
  bool get isFilteringByFemale => genderTypeFilter.value == female;
  bool get isFilteringByMale => genderTypeFilter.value == male;
  bool get isFilteringByAny => _predicateMap.isNotEmpty;
  String get textToSearch => _textToSearch.value;
  PersonGender get female => PersonGender.female;
  PersonGender get male => PersonGender.male;
  PersonGender get none => PersonGender.none;
  bool get resetDataOnFilter => false;
  List<Person> get data => _data;

  final RxMap<FilterType, Predicate<Person>> _predicateMap =
      <FilterType, Predicate<Person>>{}.obs;

  bool Function(Person) get filterPredicate {
    return (Person item) {
      // Combine all predicates using AND logic
      for (var predicate in _predicateMap.entries) {
        if (!predicate.value(item)) {
          return false; // If any predicate returns false, the result is false
        }
      }
      return true; // All predicates passed
    };
  }

  void _resetPredicates() => _predicateMap.clear();

  void setSearchText(String text) {
    _textToSearch(text);
    searchByText();
  }

  void _clearSearchText() {
    _textToSearch("");
  }

  void searchByText() {
    final String finalText = textToSearch.removeAccents().trim().toLowerCase();
    _predicateMap.value = {..._predicateMap}..remove(FilterType.text);

    if (finalText.length >= 3) {
      bool predicate(Person person) {
        final nameToCompare = person.name.removeAccents().trim().toLowerCase();
        return nameToCompare.contains(finalText);
      }

      _predicateMap.value = {..._predicateMap, FilterType.text: predicate};
    }
  }

  void _filterByGender() {
    _clearSearchText();

    if (genderTypeFilter.value == none) {
      _resetPredicates();
    } else {
      bool predicate(Person person) => person.gender == genderTypeFilter.value;

      _predicateMap.putIfAbsent(FilterType.gender, () => predicate);

      _predicateMap.removeWhere((k, v) => k == FilterType.text);
    }
  }

  void filterByMaleGender() {
    if (genderTypeFilter.value == male) {
      genderTypeFilter(none);
    } else {
      genderTypeFilter(male);
    }
    _filterByGender();
  }

  void filterByFemaleGender() {
    if (genderTypeFilter.value == female) {
      genderTypeFilter(none);
    } else {
      genderTypeFilter(female);
    }
    _filterByGender();
  }
}
