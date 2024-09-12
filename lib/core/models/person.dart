import 'package:tree_view/simple_tree/models/abstract_parent_class.dart';

enum PersonGender { female, male, none }

class Person extends ParentProtocol {
  PersonGender gender;
  @override
  int? parentId;
  String name;
  bool fat;
  @override
  int id;

  Person({
    this.gender = PersonGender.male,
    required this.name,
    required this.id,
    this.fat = false,
    this.parentId,
  });

  bool get female => gender == PersonGender.female;
  bool get male => gender == PersonGender.male;

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
