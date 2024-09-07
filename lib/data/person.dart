import 'package:tree_view/models/person.dart';

final Person tree = Person(
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
            Person(
              name: "Liu Kang",
              id: 18,
              gender: PersonGender.male,
            ),
            Person(
              name: "Scottie",
              id: 19,
              gender: PersonGender.female,
            ),
          ],
        ),
        Person(
          name: "Ana",
          id: 8,
          gender: PersonGender.female,
        ),
        Person(
          id: 9,
          name: "Alisson",
          gender: PersonGender.male,
          children: [
            Person(
              name: "Luke",
              id: 20,
              gender: PersonGender.male,
            ),
          ],
        ),
      ],
    ),
    Person(
      id: 3,
      name: "Erika Jesus",
      gender: PersonGender.female,
      children: [
        Person(
          name: "Erik",
          id: 10,
          gender: PersonGender.male,
        ),
        Person(
          id: 11,
          name: "Evellyn",
          gender: PersonGender.female,
          children: [
            Person(
              id: 12,
              name: "Romeu e Julieta",
              children: [
                Person(
                  name: "Cuxurrin 1",
                  id: 13,
                  gender: PersonGender.male,
                ),
                Person(
                  name: "Cuxurrin 2",
                  id: 14,
                  gender: PersonGender.female,
                ),
                Person(
                  name: "Cuxurrin 3",
                  id: 15,
                  gender: PersonGender.male,
                ),
                Person(
                  name: "Cuxurrin 4",
                  id: 16,
                  gender: PersonGender.female,
                ),
                Person(
                  name: "Cuxurrin 5",
                  id: 17,
                  gender: PersonGender.male,
                ),
              ],
            ),
          ],
        ),
        Person(
          name: "Everthon",
          id: 21,
          gender: PersonGender.male,
        ),
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
            Person(
              name: "Bruno",
              id: 23,
              gender: PersonGender.male,
            ),
          ],
        ),
        Person(
          name: "Mariah",
          id: 24,
          gender: PersonGender.female,
        ),
      ],
    ),
    Person(
      name: "Eudes Jesus",
      id: 5,
      gender: PersonGender.male,
    ),
    Person(
      id: 6,
      name: "Hélida Jesus",
      gender: PersonGender.female,
      children: [
        Person(
          name: "César",
          id: 25,
          gender: PersonGender.male,
        ),
        Person(
          name: "Silas",
          id: 26,
          gender: PersonGender.male,
        ),
        Person(
          id: 27,
          name: "Hugo Jesus",
          gender: PersonGender.male,
          children: [
            Person(
              name: "Daniela",
              id: 28,
              gender: PersonGender.female,
            ),
            Person(
              name: "Eduardo",
              id: 29,
              gender: PersonGender.male,
              children: [
                Person(
                  id: 30,
                  name: "Heitor Jesus",
                  gender: PersonGender.male,
                  children: [
                    Person(
                      name: "Lucas",
                      id: 31,
                      gender: PersonGender.male,
                    ),
                    Person(
                      name: "Livia",
                      id: 32,
                      gender: PersonGender.female,
                      children: [
                        Person(
                          id: 33,
                          name: "João Jesus",
                          gender: PersonGender.male,
                          children: [
                            Person(
                              name: "Igor",
                              id: 34,
                              gender: PersonGender.male,
                            ),
                            Person(
                              name: "Iara",
                              id: 35,
                              gender: PersonGender.female,
                            ),
                          ],
                        ),
                        Person(
                          id: 36,
                          name: "Carla Jesus",
                          gender: PersonGender.female,
                          children: [
                            Person(
                              name: "Vinicius",
                              id: 37,
                              gender: PersonGender.male,
                            ),
                            Person(
                              name: "Vitoria",
                              id: 38,
                              gender: PersonGender.female,
                              children: [
                                Person(
                                  id: 39,
                                  name: "Ricardo Jesus",
                                  gender: PersonGender.male,
                                  children: [
                                    Person(
                                      name: "Guilherme",
                                      id: 40,
                                      gender: PersonGender.male,
                                    ),
                                    Person(
                                      name: "Gabriela",
                                      id: 41,
                                      gender: PersonGender.female,
                                    ),
                                  ],
                                ),
                                Person(
                                  id: 42,
                                  name: "Fabiana Jesus",
                                  gender: PersonGender.female,
                                  children: [
                                    Person(
                                      name: "Felipe",
                                      id: 43,
                                      gender: PersonGender.male,
                                      children: [
                                        Person(
                                          id: 51,
                                          name: "Viviane Jesus",
                                          gender: PersonGender.female,
                                          children: [
                                            Person(
                                              name: "Victor",
                                              id: 52,
                                              gender: PersonGender.male,
                                            ),
                                            Person(
                                              name: "Valeria",
                                              id: 53,
                                              gender: PersonGender.female,
                                            ),
                                          ],
                                        ),
                                        Person(
                                          id: 54,
                                          name: "Otávio Jesus",
                                          gender: PersonGender.male,
                                          children: [
                                            Person(
                                              name: "Paulo",
                                              id: 55,
                                              gender: PersonGender.male,
                                            ),
                                            Person(
                                              name: "Priscila",
                                              id: 56,
                                              gender: PersonGender.female,
                                            ),
                                          ],
                                        ),
                                        Person(
                                          id: 57,
                                          name: "Rafael Jesus",
                                          gender: PersonGender.male,
                                          children: [
                                            Person(
                                              name: "Renato",
                                              id: 58,
                                              gender: PersonGender.male,
                                            ),
                                            Person(
                                              name: "Raquel",
                                              id: 59,
                                              gender: PersonGender.female,
                                            ),
                                          ],
                                        ),
                                        Person(
                                          id: 60,
                                          name: "Marta Jesus",
                                          gender: PersonGender.female,
                                          children: [
                                            Person(
                                              name: "Mário",
                                              id: 61,
                                              gender: PersonGender.male,
                                            ),
                                            Person(
                                              name: "Mariana",
                                              id: 62,
                                              gender: PersonGender.female,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Person(
                                      name: "Fernanda",
                                      id: 44,
                                      gender: PersonGender.female,
                                      children: [
                                        Person(
                                          id: 45,
                                          name: "Tatiane Jesus",
                                          gender: PersonGender.female,
                                          children: [
                                            Person(
                                              name: "Tiago",
                                              id: 46,
                                              gender: PersonGender.male,
                                            ),
                                            Person(
                                              name: "Tatiana",
                                              id: 47,
                                              gender: PersonGender.female,
                                            ),
                                          ],
                                        ),
                                        Person(
                                          id: 48,
                                          name: "Márcio Jesus",
                                          gender: PersonGender.male,
                                          children: [
                                            Person(
                                              name: "Marcelo",
                                              id: 49,
                                              gender: PersonGender.male,
                                            ),
                                            Person(
                                              name: "Marina",
                                              id: 50,
                                              gender: PersonGender.female,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Person(
                              id: 63,
                              name: "Débora Jesus",
                              gender: PersonGender.female,
                              children: [
                                Person(
                                  name: "Diego",
                                  id: 64,
                                  gender: PersonGender.male,
                                ),
                                Person(
                                  name: "Diana",
                                  id: 65,
                                  gender: PersonGender.female,
                                ),
                              ],
                            ),
                            Person(
                              id: 66,
                              name: "Roberta Jesus",
                              gender: PersonGender.female,
                              children: [
                                Person(
                                  name: "Ronaldo",
                                  id: 67,
                                  gender: PersonGender.male,
                                ),
                                Person(
                                  name: "Rita",
                                  id: 68,
                                  gender: PersonGender.female,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Person(
                  id: 69,
                  name: "Luciano Jesus",
                  gender: PersonGender.male,
                  children: [
                    Person(
                      name: "Leonardo",
                      id: 70,
                      gender: PersonGender.male,
                    ),
                    Person(
                      name: "Lorena",
                      id: 71,
                      gender: PersonGender.female,
                      children: [
                        Person(
                          id: 72,
                          name: "Silvia Jesus",
                          gender: PersonGender.female,
                          children: [
                            Person(
                              name: "Samuel",
                              id: 73,
                              gender: PersonGender.male,
                            ),
                            Person(
                              name: "Sarah",
                              id: 74,
                              gender: PersonGender.female,
                            ),
                          ],
                        ),
                        Person(
                          id: 75,
                          name: "Renata Jesus",
                          gender: PersonGender.female,
                          children: [
                            Person(
                              name: "Rodrigo",
                              id: 76,
                              gender: PersonGender.male,
                            ),
                            Person(
                              name: "Rebeca",
                              id: 77,
                              gender: PersonGender.female,
                              children: [
                                Person(
                                  id: 78,
                                  name: "Nathalia Jesus",
                                  gender: PersonGender.female,
                                  children: [
                                    Person(
                                      name: "Nelson",
                                      id: 79,
                                      gender: PersonGender.male,
                                    ),
                                    Person(
                                      name: "Nicole",
                                      id: 80,
                                      gender: PersonGender.female,
                                    ),
                                  ],
                                ),
                                Person(
                                  id: 81,
                                  name: "Patricia Jesus",
                                  gender: PersonGender.female,
                                  children: [
                                    Person(
                                      name: "Pedro",
                                      id: 82,
                                      gender: PersonGender.male,
                                    ),
                                    Person(
                                      name: "Paloma",
                                      id: 83,
                                      gender: PersonGender.female,
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
                Person(
                  id: 93,
                  name: "Felipe Jesus",
                  gender: PersonGender.male,
                  children: [
                    Person(
                      name: "Fernando",
                      id: 94,
                      gender: PersonGender.male,
                    ),
                    Person(
                      name: "Fabiana",
                      id: 95,
                      gender: PersonGender.female,
                    ),
                  ],
                ),
                Person(
                  id: 96,
                  name: "Gustavo Jesus",
                  gender: PersonGender.male,
                  children: [
                    Person(
                      name: "Giovanni",
                      id: 97,
                      gender: PersonGender.male,
                    ),
                    Person(
                      name: "Giovana",
                      id: 98,
                      gender: PersonGender.female,
                      children: [
                        Person(
                          id: 84,
                          name: "Sergio Jesus",
                          gender: PersonGender.male,
                          children: [
                            Person(
                              name: "Sofia",
                              id: 85,
                              gender: PersonGender.female,
                            ),
                            Person(
                              name: "Saulo",
                              id: 86,
                              gender: PersonGender.male,
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
        Person(
          id: 87,
          name: "Antônio Jesus",
          gender: PersonGender.male,
          children: [
            Person(
              name: "Arthur",
              id: 88,
              gender: PersonGender.male,
            ),
            Person(
              name: "Amanda",
              id: 89,
              gender: PersonGender.female,
            ),
          ],
        ),
        Person(
          id: 90,
          name: "Isabel Jesus",
          gender: PersonGender.female,
          children: [
            Person(
              name: "Igor",
              id: 91,
              gender: PersonGender.male,
            ),
            Person(
              name: "Isis",
              id: 92,
              gender: PersonGender.female,
            ),
          ],
        ),
        Person(
          id: 99,
          name: "Juliana Jesus",
          gender: PersonGender.female,
          children: [
            Person(
              name: "Jorge",
              id: 100,
              gender: PersonGender.male,
            ),
          ],
        ),
      ],
    ),
  ],
);
