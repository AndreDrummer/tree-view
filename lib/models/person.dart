enum PersonGender { female, male, none }

class Person {
  PersonGender gender;
  String name;
  int id;

  Person({
    this.gender = PersonGender.male,
    required this.name,
    required this.id,
  });

  @override
  String toString() {
    return ''''
      name: $name
      gender: $gender
      id: $id
    ''';
  }
}
