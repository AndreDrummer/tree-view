import 'package:tree_view/features/assets/widgets/inline_checkbox.dart';
import 'package:tree_view/features/assets/widgets/input_search.dart';
import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({
    super.key,
    this.darkModeIsON = true,
    this.scrollFunction,
  });
  final Function(bool)? scrollFunction;
  final bool darkModeIsON;

  @override
  Widget build(BuildContext context) {
    final headerBackgroundColor = darkModeIsON ? Colors.black : Colors.white;
    final elementsColor = darkModeIsON ? Colors.white : Colors.black;

    return Container(
      color: headerBackgroundColor,
      child: Column(
        children: [
          InputSearch(
            search: (text) {},
            hintText: 'Buscar pessoa ou funcão',
            color: elementsColor,
          ),
          Row(
            children: [
              InlineCheckbox(
                value: false,
                onPressed: () {
                  // controller.filterByMaleGender();
                  // scrollFunction?.call(controller.isFilteringByAny);
                },
                activeColor: Colors.blue,
                borderColor: elementsColor,
                textColor: elementsColor,
                text: "Male",
              ),
              InlineCheckbox(
                value: false,
                onPressed: () {
                  // controller.filterByFemaleGender();
                  // scrollFunction?.call(controller.isFilteringByAny);
                },
                activeColor: Colors.pink,
                borderColor: elementsColor,
                textColor: elementsColor,
                text: "Female",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
