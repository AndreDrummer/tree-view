import 'package:flutter/material.dart';
import 'package:tree_view/models/person.dart';

class Controller with ChangeNotifier {
  static final Person _originalRoot = Person(
    id: 1,
    name: "José Francisco e Maria de Jesus",
    gender: PersonGender.male,
    children: [
      Person(
        id: 2,
        name: "Edna Jesus",
        gender: PersonGender.female,
        children: [
          Person(
            id: 7,
            name: "André",
            gender: PersonGender.male,
            children: [
              Person(name: "Liu Kang", id: 18, gender: PersonGender.male),
              Person(name: "Scottie", id: 19, gender: PersonGender.female),
            ],
          ),
          Person(name: "Ana", id: 8, gender: PersonGender.female),
          Person(
            id: 9,
            name: "Alisson",
            gender: PersonGender.male,
            children: [
              Person(name: "Luke", id: 20, gender: PersonGender.male),
            ],
          ),
        ],
      ),
      Person(
        id: 3,
        name: "Erika Jesus",
        gender: PersonGender.female,
        children: [
          Person(name: "Erik", id: 10, gender: PersonGender.male),
          Person(
            id: 11,
            name: "Evellyn",
            gender: PersonGender.female,
            children: [
              Person(
                id: 12,
                name: "Romeu e Julieta",
                children: [
                  Person(name: "Cuxurrin 1", id: 13, gender: PersonGender.male),
                  Person(
                      name: "Cuxurrin 2", id: 14, gender: PersonGender.female),
                  Person(name: "Cuxurrin 3", id: 15, gender: PersonGender.male),
                  Person(
                      name: "Cuxurrin 4", id: 16, gender: PersonGender.female),
                  Person(name: "Cuxurrin 5", id: 17, gender: PersonGender.male),
                ],
              ),
            ],
          ),
          Person(name: "Everthon", id: 21, gender: PersonGender.male),
        ],
      ),
      Person(
        id: 4,
        name: "Edson Jesus",
        gender: PersonGender.male,
        children: [
          Person(
            id: 22,
            name: "Wadson Jesus",
            gender: PersonGender.male,
            children: [
              Person(name: "Bruno", id: 23, gender: PersonGender.male),
            ],
          ),
          Person(name: "Mariah", id: 24, gender: PersonGender.female),
        ],
      ),
      Person(name: "Eudes Jesus", id: 5, gender: PersonGender.male),
      Person(
        id: 6,
        name: "Hélida Jesus",
        gender: PersonGender.female,
        children: [
          Person(name: "César", id: 25, gender: PersonGender.male),
          Person(name: "Silas", id: 26, gender: PersonGender.male),
        ],
      ),
    ],
  );

  static Person _root = _originalRoot;

  Person get root => _root;

  void _setRoot(Person node) {
    _root = node;
  }

  PersonGender genderTypeFilter = PersonGender.none;
  PersonGender get female => PersonGender.female;
  PersonGender get male => PersonGender.male;
  PersonGender get none => PersonGender.none;

  void toogleNodeView(Person node) {
    final updatedNode = node.expanded ? node.close() : node.open();

    bool nodeWithIdPredicate(Person innerNode) {
      return innerNode.id == node.id;
    }

    final newNode = root.toggleNode(updatedNode, nodeWithIdPredicate);

    if (node.id == root.id) _setRoot(newNode ?? root);

    notifyListeners();
  }

  void filterByMaleGender() {
    if (genderTypeFilter == male) {
      genderTypeFilter = none;
    } else {
      genderTypeFilter = male;
    }

    _filterByGender();
  }

  void filterByFemaleGender() {
    if (genderTypeFilter == female) {
      genderTypeFilter = none;
    } else {
      genderTypeFilter = female;
    }

    _filterByGender();
  }

  void _filterByGender() {
    _setRoot(_originalRoot);
    final newNode = root.buildTreeWithPredicate(
      (person) {
        return person.gender == genderTypeFilter;
      },
    );
    _setRoot(newNode ?? root);

    notifyListeners();
  }
}
