import 'package:tree_view/core/models/person.dart';

final dataPerson = List.generate(200, (i) {
  return Person(
    id: i,
    name: "Garibalda Bujão $i",
    gender: PersonGender.female,
    parentId: i == 0 ? null : 0,
    fat: i % 2 == 0,
  );
});

// final dataPerson = [
//   Person(
//     id: 9900,
//     name: "Batuira Carneiro",
//     gender: PersonGender.male,
//     fat: false,
//   ),
//   Person(
//     id: 0,
//     name: "José e Maria",
//     gender: PersonGender.male,
//     fat: false,
//   ),
//   Person(
//     id: 8790,
//     name: "Garibalda Pinto",
//     gender: PersonGender.female,
//     fat: true,
//   ),
//   Person(
//     id: 9876,
//     name: "Salamantra Bujão",
//     gender: PersonGender.female,
//     parentId: 8790,
//     fat: true,
//   ),
  
//   Person(
//     id: 6574,
//     name: "Corno Manso",
//     gender: PersonGender.male,
//     parentId: 9900,
//     fat: true,
//   ),
//   Person(
//     id: 1234,
//     name: "Paula Tejando",
//     gender: PersonGender.male,
//     parentId: 8790,
//     fat: true,
//   ),
//   Person(
//     id: 2,
//     name: "Edna Jesus",
//     gender: PersonGender.female,
//     parentId: 0,
//     fat: false,
//   ),
//   Person(
//     id: 7,
//     gender: PersonGender.male,
//     name: "André",
//     parentId: 2,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.male,
//     name: "Liu Kang",
//     parentId: 7,
//     id: 18,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.female,
//     name: "Scottie",
//     parentId: 7,
//     id: 19,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.female,
//     name: "Ana",
//     parentId: 2,
//     id: 8,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.male,
//     name: "Alisson",
//     parentId: 2,
//     id: 9,
//     fat: true,
//   ),
//   Person(
//     gender: PersonGender.male,
//     parentId: 9,
//     name: "Luke",
//     id: 20,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.female,
//     name: "Erika Jesus",
//     parentId: 0,
//     id: 3,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.male,
//     parentId: 3,
//     name: "Erik",
//     id: 10,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.female,
//     name: "Evellyn",
//     parentId: 3,
//     id: 11,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.female,
//     name: "Romeu e Julieta",
//     parentId: 11,
//     id: 12,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.male,
//     name: "Cuxurrin 1",
//     parentId: 11,
//     id: 13,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.female,
//     name: "Cuxurrin 2",
//     parentId: 11,
//     id: 14,
//     fat: true,
//   ),
//   Person(
//     gender: PersonGender.male,
//     name: "Cuxurrin 3",
//     parentId: 11,
//     id: 15,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.female,
//     name: "Cuxurrin 4",
//     parentId: 11,
//     id: 16,
//     fat: true,
//   ),
//   Person(
//     gender: PersonGender.male,
//     name: "Cuxurrin 5",
//     parentId: 11,
//     id: 17,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.male,
//     name: "Everthon",
//     parentId: 3,
//     id: 21,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.male,
//     name: "Edson Jesus",
//     parentId: 0,
//     id: 4,
//     fat: true,
//   ),
//   Person(
//     gender: PersonGender.male,
//     name: "Wadson Jesus",
//     parentId: 4,
//     id: 22,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.male,
//     parentId: 22,
//     name: "Bruno",
//     id: 23,
//     fat: true,
//   ),
//   Person(
//     gender: PersonGender.female,
//     name: "Mariah",
//     parentId: 4,
//     id: 24,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.male,
//     name: "Eudes Jesus",
//     parentId: 0,
//     id: 5,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.female,
//     name: "Hélida Jesus",
//     parentId: 0,
//     id: 6,
//     fat: true,
//   ),
//   Person(
//     gender: PersonGender.male,
//     name: "César",
//     parentId: 6,
//     id: 25,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.male,
//     name: "Silas",
//     parentId: 6,
//     id: 26,
//     fat: true,
//   ),
//   Person(
//     gender: PersonGender.male,
//     name: "Ricardo Jesus",
//     parentId: 0,
//     id: 50,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.male,
//     name: "Child 1 of Ricardo",
//     parentId: 50,
//     id: 51,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.female,
//     name: "Child 2 of Ricardo",
//     parentId: 50,
//     id: 52,
//     fat: false,
//   ),
//   Person(
//     name: "Child 3 of Ricardo",
//     parentId: 52,
//     gender: PersonGender.male,
//     id: 53,
//     fat: true,
//   ),
//   Person(
//     gender: PersonGender.female,
//     name: "Grandchild 1 of Ricardo",
//     parentId: 53,
//     id: 54,
//   ),
//   Person(
//     name: "Grandchild 2 of Ricardo",
//     gender: PersonGender.male,
//     parentId: 54,
//     id: 55,
//     fat: true,
//   ),
//   Person(
//     id: 56,
//     name: "Grandchild 3 of Ricardo",
//     gender: PersonGender.male,
//     parentId: 55,
//     fat: true,
//   ),
//   Person(
//     name: "Grandchild 1 of Grandchild 1",
//     gender: PersonGender.male,
//     parentId: 56,
//     id: 57,
//     fat: true,
//   ),
//   Person(
//     gender: PersonGender.female,
//     name: "Grandchild 2 of Grandchild 1",
//     parentId: 57,
//     id: 58,
//     fat: true,
//   ),
//   Person(
//     name: "Grandchild 3 of Grandchild 1",
//     gender: PersonGender.male,
//     parentId: 58,
//     id: 59,
//     fat: false,
//   ),
//   Person(
//     gender: PersonGender.female,
//     name: "Grandchild 1 of Grandchild 2",
//     parentId: 59,
//     id: 60,
//     fat: true,
//   ),
//   Person(
//     name: "Grandchild 2 of Grandchild 2",
//     gender: PersonGender.male,
//     parentId: 60,
//     id: 61,
//     fat: true,
//   ),
//   Person(
//     name: "Grandchild 3 of Grandchild 2",
//     gender: PersonGender.female,
//     parentId: 61,
//     id: 62,
//     fat: true,
//   ),
//   Person(
//     name: "Grandchild 1 of Grandchild 3",
//     gender: PersonGender.male,
//     parentId: 62,
//     id: 63,
//   ),
//   Person(
//     name: "Grandchild 2 of Grandchild 3",
//     gender: PersonGender.female,
//     parentId: 63,
//     id: 64,
//     fat: true,
//   ),
//   Person(
//     name: "Grandchild 3 of Grandchild 3",
//     gender: PersonGender.male,
//     parentId: 64,
//     id: 65,
//   ),
//   Person(
//     name: "Grandchild 4 of Grandchild 3",
//     gender: PersonGender.female,
//     parentId: 65,
//     id: 66,
//     fat: true,
//   ),
//   Person(
//     name: "Grandchild 4 of Grandchild 2",
//     gender: PersonGender.male,
//     parentId: 66,
//     id: 67,
//   ),
//   Person(
//     name: "Grandchild 4 of Grandchild 1",
//     gender: PersonGender.female,
//     parentId: 67,
//     id: 68,
//     fat: true,
//   ),
//   Person(
//     name: "Child 19 of Ricardo",
//     gender: PersonGender.male,
//     parentId: 68,
//     id: 69,
//   ),
//   Person(
//     name: "Child 20 of Ricardo",
//     gender: PersonGender.female,
//     parentId: 69,
//     id: 70,
//     fat: true,
//   ),
// ];
