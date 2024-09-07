import 'package:tree_view/models/person.dart';

import '../models/node.dart';

final tree = Node<Person>(
  id: 1,
  data: Person(
    id: 1,
    name: "José Francisco e Maria de Jesus",
    gender: PersonGender.male,
  ),
  children: [
    Node<Person>(
      id: 2,
      data: Person(
        id: 2,
        name: "Edna Jesus",
        gender: PersonGender.female,
      ),
      children: [
        Node<Person>(
          id: 7,
          data: Person(
            id: 7,
            name: "André",
            gender: PersonGender.male,
          ),
          children: [
            Node<Person>(
              id: 18,
              data: Person(
                id: 18,
                name: "Liu Kang",
                gender: PersonGender.male,
              ),
            ),
            Node<Person>(
              id: 19,
              data: Person(
                id: 19,
                name: "Scottie",
                gender: PersonGender.female,
              ),
            ),
          ],
        ),
        Node<Person>(
          id: 8,
          data: Person(
            id: 8,
            name: "Ana",
            gender: PersonGender.female,
          ),
        ),
        Node<Person>(
          id: 9,
          data: Person(
            id: 9,
            name: "Alisson",
            gender: PersonGender.male,
          ),
          children: [
            Node<Person>(
              id: 20,
              data: Person(
                id: 20,
                name: "Luke",
                gender: PersonGender.male,
              ),
            ),
          ],
        ),
      ],
    ),
    Node<Person>(
      id: 3,
      data: Person(
        id: 3,
        name: "Erika Jesus",
        gender: PersonGender.female,
      ),
      children: [
        Node<Person>(
          id: 10,
          data: Person(
            id: 10,
            name: "Erik",
            gender: PersonGender.male,
          ),
        ),
        Node<Person>(
          id: 11,
          data: Person(
            id: 11,
            name: "Evellyn",
            gender: PersonGender.female,
          ),
          children: [
            Node<Person>(
              id: 12,
              data: Person(
                id: 12,
                name: "Romeu e Julieta",
              ),
              children: [
                Node<Person>(
                  id: 13,
                  data: Person(
                    id: 13,
                    name: "Cuxurrin 1",
                    gender: PersonGender.male,
                  ),
                ),
                Node<Person>(
                  id: 14,
                  data: Person(
                    id: 14,
                    name: "Cuxurrin 2",
                    gender: PersonGender.female,
                  ),
                ),
                Node<Person>(
                  id: 15,
                  data: Person(
                    id: 15,
                    name: "Cuxurrin 3",
                    gender: PersonGender.male,
                  ),
                ),
                Node<Person>(
                  id: 16,
                  data: Person(
                    id: 16,
                    name: "Cuxurrin 4",
                    gender: PersonGender.female,
                  ),
                ),
                Node<Person>(
                  id: 17,
                  data: Person(
                    id: 17,
                    name: "Cuxurrin 5",
                    gender: PersonGender.male,
                  ),
                ),
              ],
            ),
          ],
        ),
        Node<Person>(
          id: 21,
          data: Person(
            id: 21,
            name: "Everthon",
            gender: PersonGender.male,
          ),
        ),
      ],
    ),
    Node<Person>(
      id: 4,
      data: Person(
        id: 4,
        name: "Edson Jesus",
        gender: PersonGender.male,
      ),
      children: [
        Node<Person>(
          id: 22,
          data: Person(
            id: 22,
            name: "Wadson Jesus",
            gender: PersonGender.male,
          ),
          children: [
            Node<Person>(
              id: 23,
              data: Person(
                id: 23,
                name: "Bruno",
                gender: PersonGender.male,
              ),
            ),
          ],
        ),
        Node<Person>(
          id: 24,
          data: Person(
            id: 24,
            name: "Mariah",
            gender: PersonGender.female,
          ),
        ),
      ],
    ),
    Node<Person>(
      id: 5,
      data: Person(
        id: 5,
        name: "Eudes Jesus",
        gender: PersonGender.male,
      ),
    ),
    Node<Person>(
      id: 6,
      data: Person(
        id: 6,
        name: "Hélida Jesus",
        gender: PersonGender.female,
      ),
      children: [
        Node<Person>(
          id: 25,
          data: Person(
            id: 25,
            name: "César",
            gender: PersonGender.male,
          ),
        ),
        Node<Person>(
          id: 26,
          data: Person(
            id: 26,
            name: "Silas",
            gender: PersonGender.male,
          ),
        ),
      ],
    ),
  ],
);
