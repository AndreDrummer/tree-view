import 'dart:math';

import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';
import 'package:tree_view/core/http/http_provider.dart';
import 'package:tree_view/core/utils/extensions.dart';
import 'package:tree_view/core/models/data_item.dart';
import 'package:tree_view/core/models/location.dart';
import 'package:tree_view/core/models/company.dart';
import 'package:tree_view/core/http/endpoints.dart';
import 'package:tree_view/core/models/enums.dart';
import 'package:tree_view/core/models/asset.dart';
import 'package:get/get.dart';

typedef Predicate<DataItem> = bool Function(DataItem item);

enum FilterType {
  sensorType,
  text,
}

class AssetsController extends GetxController {
  final rootData = DataItem(kind: ItemKind.location, name: "", id: "");
  Rx<AssetFilter> itemFilter = AssetFilter.none.obs;

  static List<Location> _locations = <Location>[];
  static List<Asset> _assets = <Asset>[];

  static final RxList<DataItem> _data = <DataItem>[].obs;

  final RxString _textToSearch = ''.obs;

  final RxString _feedbackText = ''.obs;
  final RxBool _isLoading = false.obs;

  late HttpProvider _httpProvider;

  late Company _companyToSearch;

  @override
  void onInit() {
    _httpProvider = Get.find();
    super.onInit();
  }

  // Getters
  bool get isFilteringByVibration => itemFilter.value == vibration;
  bool get isFilteringByAny => _predicateFilterMap.isNotEmpty;
  bool get isFilteringByEnergy => itemFilter.value == energy;
  AssetFilter get vibration => AssetFilter.vibration;
  String get feedbackText => _feedbackText.value;
  String get textToSearch => _textToSearch.value;
  AssetFilter get energy => AssetFilter.energy;
  AssetFilter get none => AssetFilter.none;
  bool get isLoading => _isLoading.value;
  List<ParentProtocol> get data => _data;
  bool get resetDataOnFilter => false;

  final RxMap<FilterType, Predicate<DataItem>> _predicateFilterMap =
      <FilterType, Predicate<DataItem>>{}.obs;

  bool Function(DataItem) get filterPredicate {
    return (DataItem item) {
      // Combine all predicates using AND logic
      for (var predicate in _predicateFilterMap.entries) {
        if (!predicate.value(item)) {
          return false; // If any predicate returns false, the result is false
        }
      }
      return true; // All predicates passed
    };
  }

  void _resetPredicates() => _predicateFilterMap.clear();

  Future loadCompanyItems(Company company) async {
    _companyToSearch = company;
    setLoading();
    await _loadCompanyLocations();
    await _loadCompanyAssets();
    final sample = DataItem.fromList([..._locations, ..._assets]);
    _data(sample.sublist(0, min(sample.length, 100)));
    resetLoading();
  }

  void setSearchText(String text) {
    _textToSearch(text);
    searchByText();
  }

  void _clearSearchText() {
    _textToSearch("");
  }

  void searchByText() {
    final String finalText = textToSearch.removeAccents().trim().toLowerCase();
    _predicateFilterMap.value = {..._predicateFilterMap}
      ..remove(FilterType.text);

    if (finalText.length >= 3) {
      bool predicate(DataItem item) {
        final nameToCompare = item.name.removeAccents().trim().toLowerCase();
        return nameToCompare.contains(finalText);
      }

      _predicateFilterMap.value = {
        ..._predicateFilterMap,
        FilterType.text: predicate
      };
    }
  }

  void filterByEnergy() {
    if (itemFilter.value == energy) {
      itemFilter(none);
    } else {
      itemFilter(energy);
    }
    _filterBySensor();
  }

  void filterByVibration() {
    if (itemFilter.value == vibration) {
      itemFilter(none);
    } else {
      itemFilter(vibration);
    }
    _filterBySensor();
  }

  void setLoading({String? feedbackText}) {
    _feedbackText(feedbackText);
    _isLoading(true);
  }

  void resetLoading() {
    _feedbackText('');
    _isLoading(false);
  }

  Future<void> _loadCompanyLocations() async {
    _feedbackText('Buscando Locais de ${_companyToSearch.name}');
    final response = await _httpProvider.getLocations(
      Endpoints.locations(_companyToSearch.id),
    );

    if (response.isOk) {
      _locations = response.body!;
    }
  }

  Future<void> _loadCompanyAssets() async {
    _feedbackText('Buscando Ativos de ${_companyToSearch.name}');
    final response = await _httpProvider.getAssets(
      Endpoints.assets(_companyToSearch.id),
    );

    if (response.isOk) {
      _assets = response.body!;
    }
  }

  void _filterBySensor() {
    _clearSearchText();

    if (itemFilter.value == none) {
      _resetPredicates();
    } else {
      bool predicate(DataItem item) => item.sensorType == itemFilter.value.name;

      _predicateFilterMap.putIfAbsent(FilterType.sensorType, () => predicate);

      _predicateFilterMap.removeWhere((k, v) => k == FilterType.text);
    }
  }
}
