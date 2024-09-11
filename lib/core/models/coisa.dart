import 'package:tree_view/core/models/asset.dart';
import 'package:tree_view/core/models/enums.dart';
import 'package:tree_view/core/models/location.dart';
import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';

enum CoisaEnum {
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

class Coisa extends Parent {
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

  Coisa({
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

  static List<Coisa> fromItemList(List item) {
    List<Coisa> coisa = [];

    for (final i in item) {
      if (i.kind == ItemKind.location) {
        final coisaLocation = (i as Location);
        coisa.add(
          Coisa(
            name: coisaLocation.name,
            kind: coisaLocation.kind,
            id: coisaLocation.id,
          ),
        );
      } else {
        final coisaAsset = (i as Asset);

        coisa.add(
          Coisa(
            sensorType: coisaAsset.sensorType,
            locationId: coisaAsset.locationId,
            gatewayId: coisaAsset.gatewayId,
            parentId: coisaAsset.parentId,
            sensorId: coisaAsset.sensorId,
            status: coisaAsset.status,
            name: coisaAsset.name,
            kind: coisaAsset.kind,
            id: coisaAsset.id,
          ),
        );
      }
    }

    return coisa;
  }

  // Method to convert a Coisa to JSON
  Map<String, dynamic> toJson() {
    return {
      CoisaEnum.sensorType.name: sensorType,
      CoisaEnum.locationId.name: locationId,
      CoisaEnum.gatewayId.name: gatewayId,
      CoisaEnum.sensorId.name: sensorId,
      CoisaEnum.parentId.name: parentId,
      CoisaEnum.status.name: status,
      CoisaEnum.kind.name: kind,
      CoisaEnum.name.name: name,
      CoisaEnum.id.name: id,
    };
  }
}
