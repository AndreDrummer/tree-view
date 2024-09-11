import 'package:tree_view/core/models/data_item.dart';
import 'package:tree_view/core/utils/extensions.dart';
import 'package:tree_view/core/models/enums.dart';
import 'package:tree_view/core/data/data_item.dart';
import 'package:get/get.dart';
import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';

typedef Predicate<DataItem> = bool Function(DataItem item);

enum FilterType {
  sensorType,
  text,
}

class AssetsController extends GetxController {
  Rx<AssetFilter> tractianItenFilter = AssetFilter.none.obs;
  final RxList<DataItem> _data = dataItem.obs;
  final RxString _textToSearch = "".obs;

  // Getters
  bool get isFilteringByEnergy => tractianItenFilter.value == energy;
  bool get isFilteringByVibration => tractianItenFilter.value == vibration;
  bool get isFilteringByAny => _predicateMap.isNotEmpty;
  String get textToSearch => _textToSearch.value;
  AssetFilter get vibration => AssetFilter.vibration;
  AssetFilter get energy => AssetFilter.energy;
  AssetFilter get none => AssetFilter.none;
  bool get resetDataOnFilter => false;
  List<Parent> get data => _data;

  final RxMap<FilterType, Predicate<DataItem>> _predicateMap =
      <FilterType, Predicate<DataItem>>{}.obs;

  bool Function(DataItem) get filterPredicate {
    return (DataItem item) {
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
      bool predicate(DataItem item) {
        final nameToCompare = item.name.removeAccents().trim().toLowerCase();
        return nameToCompare.contains(finalText);
      }

      _predicateMap.value = {..._predicateMap, FilterType.text: predicate};
    }
  }

  void _filterBySensor() {
    _clearSearchText();

    if (tractianItenFilter.value == none) {
      _resetPredicates();
    } else {
      bool predicate(DataItem item) =>
          item.sensorType == tractianItenFilter.value.name;

      _predicateMap.putIfAbsent(FilterType.sensorType, () => predicate);

      _predicateMap.removeWhere((k, v) => k == FilterType.text);
    }
  }

  void filterByEnergy() {
    if (tractianItenFilter.value == energy) {
      tractianItenFilter(none);
    } else {
      tractianItenFilter(energy);
    }
    _filterBySensor();
  }

  void filterByVibration() {
    if (tractianItenFilter.value == vibration) {
      tractianItenFilter(none);
    } else {
      tractianItenFilter(vibration);
    }
    _filterBySensor();
  }
}
