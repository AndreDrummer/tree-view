import 'package:tree_view/simple_tree/builder/tree_manager.dart';
import 'package:tree_view/simple_tree/models/node_data.dart';
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
  final Rx<AssetFilter> _itemFilter = AssetFilter.none.obs;

  static final RxList<DataItem> _data = <DataItem>[].obs;
  static List<Location> _locations = <Location>[];
  static List<Asset> _assets = <Asset>[];

  final RxString _textToSearch = ''.obs;
  final RxString _feedbackText = ''.obs;

  final RxBool _hasConnectionError = false.obs;
  final RxBool _hasServerError = false.obs;
  final RxBool _isLoading = false.obs;
  final RxBool _hasError = false.obs;

  late HttpProvider _httpProvider;
  late Company _companyToSearch;
  late TreeManager treeManager;

  @override
  void onInit() {
    _httpProvider = Get.find();

    resetLoading();
    super.onInit();
  }

  void _handleErrorResponse(Response response) {
    _hasConnectionError(response.status.connectionError);
    _hasServerError(response.status.isServerError);
    _hasError(response.status.hasError);
  }

  void _resetErrorStatus() {
    _hasConnectionError(false);
    _hasServerError(false);
    _hasError(false);
  }

  // Getters
  bool get isFilteringByVibration => _itemFilter.value == vibration;
  bool get isFilteringByAny => _predicateFilterMap.isNotEmpty;
  bool get isFilteringByEnergy => _itemFilter.value == energy;

  bool get hasConnectionError => _hasConnectionError.value;
  bool get hasServerError => _hasServerError.value;
  bool get hasError => _hasError.value;

  AssetFilter get vibration => AssetFilter.vibration;
  AssetFilter get energy => AssetFilter.energy;
  AssetFilter get none => AssetFilter.none;

  String get feedbackText => _feedbackText.value;
  String get textToSearch => _textToSearch.value;

  bool get isLoading => _isLoading.value;
  bool get resetDataOnFilter => false;

  List<DataItem> get data => _data;

  Company get companyToSearch => _companyToSearch;

  final RxMap<FilterType, Predicate<DataItem>> _predicateFilterMap =
      <FilterType, Predicate<DataItem>>{}.obs;

  bool Function(DataItem) get filterPredicate {
    return (DataItem item) {
      if (_predicateFilterMap.entries.isEmpty) return true;
      for (var predicate in _predicateFilterMap.entries) {
        if (!predicate.value(item)) {
          return false;
        }
      }
      return true;
    };
  }

  Future<void> _updateTreeManager() async {
    const dataLengthThreshold = 150;

    treeManager = TreeManager(
      dataList: data,
      initializeExpanded: true,
      rootData: NodeData<DataItem>(
        id: data.first.id,
        data: data.first,
      ),
    );

    if (data.length > dataLengthThreshold) {
      await treeManager.buildTreeOnIsolate();
    } else if (data.isNotEmpty) {
      treeManager.buildTree();
    }
  }

  void _resetPredicates() => _predicateFilterMap.clear();

  void resetFilters() {
    _resetPredicates();
    _itemFilter(none);
  }

  Future loadCompanyItems(Company company) async {
    setLoading();

    _companyToSearch = company;

    await _loadCompanyLocations();
    await _loadCompanyAssets();

    _data(DataItem.fromList([..._locations, ..._assets]));

    _feedbackText('Data map mounting ...');
    await _updateTreeManager();

    resetLoading();
  }

  void setSearchText(String text) {
    _textToSearch(text);
    searchByText();
  }

  void _clearSearchText() => _textToSearch("");

  void searchByText() {
    final String finalText = textToSearch.removeAccents().trim().toLowerCase();

    _predicateFilterMap.removeWhere((k, v) => k == FilterType.text);

    if (finalText.length >= 3) {
      bool predicate(DataItem item) {
        final nameToCompare = item.name.removeAccents().trim().toLowerCase();
        return nameToCompare.contains(finalText);
      }

      _predicateFilterMap.putIfAbsent(FilterType.text, () => predicate);
    }
  }

  void filterByEnergy() {
    if (_itemFilter.value == energy) {
      _itemFilter(none);
    } else {
      _itemFilter(energy);
    }
    _filterBySensor();
  }

  void filterByVibration() {
    if (_itemFilter.value == vibration) {
      _itemFilter(none);
    } else {
      _itemFilter(vibration);
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
    _feedbackText('Searching Locations of ${_companyToSearch.name}');
    final response = await _httpProvider.getLocations(
      Endpoints.locations(_companyToSearch.id),
    );

    if (response.isOk) {
      _locations = response.body!;
      _resetErrorStatus();
    } else {
      _handleErrorResponse(response);
    }
  }

  Future<void> _loadCompanyAssets() async {
    _feedbackText('Searching assets of ${_companyToSearch.name}');
    final response = await _httpProvider.getAssets(
      Endpoints.assets(_companyToSearch.id),
    );

    if (response.isOk) {
      _assets = response.body!;
      _resetErrorStatus();
    } else {
      _handleErrorResponse(response);
    }
  }

  void _filterBySensor() {
    _clearSearchText();

    if (_itemFilter.value == none) {
      _resetPredicates();
    } else {
      bool predicate(DataItem item) =>
          item.sensorType == _itemFilter.value.name;

      _predicateFilterMap.putIfAbsent(FilterType.sensorType, () => predicate);

      _predicateFilterMap.removeWhere((k, v) => k == FilterType.text);
    }
  }
}
