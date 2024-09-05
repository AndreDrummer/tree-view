import 'package:flutter/material.dart';
import 'package:tree_view/models/person.dart';

class Controller with ChangeNotifier {
  Person _family = Person(
    id: 1,
    name: "José Francisco e Maria de Jesus",
    children: [
      Person(
        id: 2,
        name: "Edna Jesus",
        children: [
          Person(
            id: 7,
            name: "André",
            children: [
              Person(name: "Liu Kang", id: 18),
              Person(name: "Scottie", id: 19),
            ],
          ),
          Person(name: "Ana", id: 8),
          Person(
            id: 9,
            name: "Alisson",
            children: [
              Person(name: "Luke", id: 20),
            ],
          ),
        ],
      ),
      Person(
        id: 3,
        name: "Erika Jesus",
        children: [
          Person(name: "Erik", id: 10),
          Person(
            id: 11,
            name: "Evellyn",
            children: [
              Person(
                id: 12,
                name: "Romeu e Julieta",
                children: [
                  Person(name: "Cuxurrin 1", id: 13),
                  Person(name: "Cuxurrin 2", id: 14),
                  Person(name: "Cuxurrin 3", id: 15),
                  Person(name: "Cuxurrin 4", id: 16),
                  Person(name: "Cuxurrin 5", id: 17),
                ],
              ),
            ],
          ),
          Person(name: "Everthon", id: 21),
        ],
      ),
      Person(
        id: 4,
        name: "Edson Jesus",
        children: [
          Person(
            id: 22,
            name: "Wadson Jesus",
            children: [
              Person(name: "Bruno", id: 23),
            ],
          ),
          Person(name: "Mariah", id: 24),
        ],
      ),
      Person(name: "Eudes Jesus", id: 5),
      Person(
        id: 6,
        name: "Hélida Jesus",
        children: [
          Person(name: "César", id: 25),
          Person(name: "Silas", id: 26),
        ],
      ),
    ],
  );

  Person get root => _family;

  void toogleNodeView(Person node) {
    final newNode = node.toogleNodeView();
    final updatedFamily = _family.updateNode(newNode);

    _family = updatedFamily ?? _family;

    notifyListeners();
  }
}
