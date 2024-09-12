import 'package:tree_view/core/models/asset.dart';
import 'package:tree_view/core/models/enums.dart';
import 'package:tree_view/core/models/location.dart';
import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';

enum DataItemEnum {
  sensorType,
  locationId,
  gatewayId,
  parentId,
  sensorId,
  status,
  name,
  kind,
  id,
}

class DataItem extends ParentProtocol {
  final String? gatewayId; // Nullable
  final String? sensorType; // Nullable
  final String? locationId; // Nullable
  final String? sensorId; // Nullable
  @override
  final String? parentId; // Nullable
  final String? status; // Nullable
  final ItemKind kind;
  final String name;
  @override
  final String id;

  DataItem({
    required this.name,
    required this.kind,
    required this.id,
    this.sensorType,
    this.locationId,
    this.gatewayId,
    this.parentId,
    this.sensorId,
    this.status,
  });

  static List<DataItem> fromList(List item) {
    print("DADOS ${item.length}");
    List<DataItem> dataItem = [];

    for (final i in item) {
      if (i.kind == ItemKind.location) {
        final dataItemLocation = (i as Location);
        dataItem.add(
          DataItem(
            name: dataItemLocation.name,
            kind: dataItemLocation.kind,
            id: dataItemLocation.id,
          ),
        );
      } else {
        final dataItemAsset = (i as Asset);

        dataItem.add(
          DataItem(
            sensorType: dataItemAsset.sensorType,
            locationId: dataItemAsset.locationId,
            gatewayId: dataItemAsset.gatewayId,
            parentId: dataItemAsset.parentId,
            sensorId: dataItemAsset.sensorId,
            status: dataItemAsset.status,
            name: dataItemAsset.name,
            kind: dataItemAsset.kind,
            id: dataItemAsset.id,
          ),
        );
      }
    }

    return dataItem;
  }

  // Method to convert a DataItem to JSON
  Map<String, dynamic> toJson() {
    return {
      DataItemEnum.sensorType.name: sensorType,
      DataItemEnum.locationId.name: locationId,
      DataItemEnum.gatewayId.name: gatewayId,
      DataItemEnum.sensorId.name: sensorId,
      DataItemEnum.parentId.name: parentId,
      DataItemEnum.status.name: status,
      DataItemEnum.kind.name: kind,
      DataItemEnum.name.name: name,
      DataItemEnum.id.name: id,
    };
  }
}
