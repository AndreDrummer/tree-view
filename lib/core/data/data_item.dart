import 'package:tree_view/core/data/json_location_list.dart';
import 'package:tree_view/core/data/json_asset_list.dart';
import 'package:tree_view/core/models/data_item.dart';
import 'package:tree_view/core/models/location.dart';
import 'package:tree_view/core/models/asset.dart';

final _dataAsset = jsonAssetList.map((json) {
  return Asset.fromJson(json);
}).toList();

final _dataLocation = jsonLocationList.map((json) {
  return Location.fromJson(json);
}).toList();

final _itemList = [
  ..._dataLocation,
  ..._dataAsset,
];

final List<DataItem> dataItem = DataItem.fromItemList(_itemList);
