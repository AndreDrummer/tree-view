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
        Node<Person>(
          id: 50,
          data: Person(
            id: 50,
            name: "Ricardo Jesus",
            gender: PersonGender.male,
          ),
          children: [
            Node<Person>(
              id: 51,
              data: Person(
                id: 51,
                name: "Child 1 of Ricardo",
                gender: PersonGender.male,
              ),
              children: [
                Node<Person>(
                  id: 52,
                  data: Person(
                    id: 52,
                    name: "Child 2 of Ricardo",
                    gender: PersonGender.female,
                  ),
                  children: [
                    Node<Person>(
                      id: 53,
                      data: Person(
                        id: 53,
                        name: "Child 3 of Ricardo",
                        gender: PersonGender.male,
                      ),
                      children: [
                        Node<Person>(
                          id: 54,
                          data: Person(
                            id: 54,
                            name: "Child 4 of Ricardo",
                            gender: PersonGender.female,
                          ),
                          children: [
                            Node<Person>(
                              id: 55,
                              data: Person(
                                id: 55,
                                name: "Child 5 of Ricardo",
                                gender: PersonGender.male,
                              ),
                              children: [
                                Node<Person>(
                                  id: 56,
                                  data: Person(
                                    id: 56,
                                    name: "Child 6 of Ricardo",
                                    gender: PersonGender.female,
                                  ),
                                  children: [
                                    Node<Person>(
                                      id: 57,
                                      data: Person(
                                        id: 57,
                                        name: "Child 7 of Ricardo",
                                        gender: PersonGender.male,
                                      ),
                                      children: [
                                        Node<Person>(
                                          id: 58,
                                          data: Person(
                                            id: 58,
                                            name: "Child 8 of Ricardo",
                                            gender: PersonGender.female,
                                          ),
                                          children: [
                                            Node<Person>(
                                              id: 59,
                                              data: Person(
                                                id: 59,
                                                name: "Child 9 of Ricardo",
                                                gender: PersonGender.male,
                                              ),
                                              children: [
                                                Node<Person>(
                                                  id: 60,
                                                  data: Person(
                                                    id: 60,
                                                    name: "Child 10 of Ricardo",
                                                    gender: PersonGender.female,
                                                  ),
                                                  children: [
                                                    Node<Person>(
                                                      id: 61,
                                                      data: Person(
                                                        id: 61,
                                                        name:
                                                            "Child 11 of Ricardo",
                                                        gender:
                                                            PersonGender.male,
                                                      ),
                                                      children: [
                                                        Node<Person>(
                                                          id: 62,
                                                          data: Person(
                                                            id: 62,
                                                            name:
                                                                "Child 12 of Ricardo",
                                                            gender: PersonGender
                                                                .female,
                                                          ),
                                                          children: [
                                                            Node<Person>(
                                                              id: 63,
                                                              data: Person(
                                                                id: 63,
                                                                name:
                                                                    "Child 13 of Ricardo",
                                                                gender:
                                                                    PersonGender
                                                                        .male,
                                                              ),
                                                              children: [
                                                                Node<Person>(
                                                                  id: 64,
                                                                  data: Person(
                                                                    id: 64,
                                                                    name:
                                                                        "Child 14 of Ricardo",
                                                                    gender: PersonGender
                                                                        .female,
                                                                  ),
                                                                  children: [
                                                                    Node<
                                                                        Person>(
                                                                      id: 65,
                                                                      data:
                                                                          Person(
                                                                        id: 65,
                                                                        name:
                                                                            "Child 15 of Ricardo",
                                                                        gender:
                                                                            PersonGender.male,
                                                                      ),
                                                                      children: [
                                                                        Node<
                                                                            Person>(
                                                                          id: 66,
                                                                          data:
                                                                              Person(
                                                                            id: 66,
                                                                            name:
                                                                                "Child 16 of Ricardo",
                                                                            gender:
                                                                                PersonGender.female,
                                                                          ),
                                                                          children: [
                                                                            Node<Person>(
                                                                              id: 67,
                                                                              data: Person(
                                                                                id: 67,
                                                                                name: "Child 17 of Ricardo",
                                                                                gender: PersonGender.male,
                                                                              ),
                                                                              children: [
                                                                                Node<Person>(
                                                                                  id: 68,
                                                                                  data: Person(
                                                                                    id: 68,
                                                                                    name: "Child 18 of Ricardo",
                                                                                    gender: PersonGender.female,
                                                                                  ),
                                                                                  children: [
                                                                                    Node<Person>(
                                                                                      id: 69,
                                                                                      data: Person(
                                                                                        id: 69,
                                                                                        name: "Child 19 of Ricardo",
                                                                                        gender: PersonGender.male,
                                                                                      ),
                                                                                      children: [
                                                                                        Node<Person>(
                                                                                          id: 70,
                                                                                          data: Person(
                                                                                            id: 70,
                                                                                            name: "Child 20 of Ricardo",
                                                                                            gender: PersonGender.female,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
