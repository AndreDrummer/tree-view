import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';
import 'package:tree_view/core/models/enums.dart';

enum LocationEnum {
  parentId,
  kind,
  name,
  id,
}

class Location extends ParentProtocol {
  @override
  final String? parentId;

  final ItemKind kind;
  final String name;

  @override
  final String id;

  Location({
    this.kind = ItemKind.location,
    required this.name,
    required this.id,
    this.parentId,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      parentId: json[LocationEnum.parentId.name],
      name: json[LocationEnum.name.name],
      id: json[LocationEnum.id.name],
    );
  }

  static List<Location> fromList(list) {
    if (list is! List || list.isEmpty) return [];

    return list.map((json) => Location.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      LocationEnum.parentId.name: parentId,
      LocationEnum.kind.name: kind,
      LocationEnum.name.name: name,
      LocationEnum.id.name: id,
    };
  }
}
