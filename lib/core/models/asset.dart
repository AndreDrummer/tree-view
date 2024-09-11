import 'package:tree_view/core/models/enums.dart';
import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';

enum AssetEnum {
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

class Asset extends Parent {
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

  Asset({
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

  // Factory method to create a Asset from JSON
  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      locationId: json[AssetEnum.locationId.name],
      sensorType: json[AssetEnum.sensorType.name],
      gatewayId: json[AssetEnum.gatewayId.name],
      sensorId: json[AssetEnum.sensorId.name],
      parentId: json[AssetEnum.parentId.name],
      status: json[AssetEnum.status.name],
      name: json[AssetEnum.name.name],
      id: json[AssetEnum.id.name],
      kind: kindDefiner(json),
    );
  }

  static List<Asset> fromList(list) {
    if (list is! List || list.isEmpty) return [];

    return list.map((json) => Asset.fromJson(json)).toList();
  }

  // Method to convert a Asset to JSON
  Map<String, dynamic> toJson() {
    return {
      AssetEnum.sensorType.name: sensorType,
      AssetEnum.locationId.name: locationId,
      AssetEnum.gatewayId.name: gatewayId,
      AssetEnum.sensorId.name: sensorId,
      AssetEnum.parentId.name: parentId,
      AssetEnum.status.name: status,
      AssetEnum.kind.name: kind,
      AssetEnum.name.name: name,
      AssetEnum.id.name: id,
    };
  }

  static ItemKind kindDefiner(Map<String, dynamic> json) {
    if (json[AssetEnum.sensorType.name] != null) {
      return ItemKind.component;
    } else {
      return ItemKind.asset;
    }
  }
}
