import 'package:tree_view/models/person.dart';

class Controller {
  final family = Person(
    name: "José Francisco e Maria de Jesus",
    expanded: true,
    children: [
      Person(
        name: "Edna Jesus",
        expanded: true,
        children: [
          Person(
            name: "André",
            expanded: true,
            children: [
              Person(name: "Liu Kang"),
              Person(name: "Scottie"),
            ],
          ),
          Person(name: "Ana"),
          Person(
            name: "Alisson",
            children: [
              Person(name: "Luke"),
            ],
          ),
        ],
      ),
      Person(
        name: "Erika Jesus",
        children: [
          Person(name: "Erik"),
          Person(
            name: "Evellyn",
            children: [
              Person(
                name: "Romeu e Julieta",
                children: [
                  Person(name: "Cuxurrin 1"),
                  Person(name: "Cuxurrin 2"),
                  Person(name: "Cuxurrin 3"),
                  Person(name: "Cuxurrin 4"),
                  Person(name: "Cuxurrin 5"),
                ],
              ),
            ],
          ),
          Person(name: "Everthon"),
        ],
      ),
      Person(
        name: "Edson Jesus",
        expanded: true,
        children: [
          Person(
            name: "Wadson Jesus",
            children: [
              Person(name: "Bruno"),
            ],
          ),
          Person(name: "Mariah"),
        ],
      ),
      Person(name: "Eudes Jesus"),
      Person(
        name: "Hélida Jesus",
        expanded: true,
        children: [
          Person(name: "César"),
          Person(name: "Silas"),
        ],
      ),
    ],
  );

  Person closeNode(Person node) => node.closeNode();
}
