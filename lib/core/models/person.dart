import 'package:tree_view/core/tree/node.dart';

enum PersonGender { female, male, none }

class Person extends TOString {
  PersonGender gender;
  int? parentId;
  String name;
  int id;

  Person({
    this.gender = PersonGender.male,
    required this.name,
    required this.id,
    this.parentId,
  });

  @override
  String toString() {
    return ''''
      parentId: $parentId,
      gender: $gender
      name: $name
      id: $id
    ''';
  }
}
