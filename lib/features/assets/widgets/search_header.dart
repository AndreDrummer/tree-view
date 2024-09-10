import 'package:tree_view/features/assets/widgets/inline_checkbox.dart';
import 'package:tree_view/features/assets/widgets/input_search.dart';
import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({
    super.key,
    this.darkMode = true,
    this.scrollFunction,
    this.onFilterByText,
    this.onFilterByFemale,
    this.onFilterByMale,
    this.isFilteringByFemale = false,
    this.isFilteringByMale = false,
    required this.textInitialValue,
  });
  final Function(String text)? onFilterByText;
  final Function(bool)? scrollFunction;
  final Function()? onFilterByFemale;
  final Function()? onFilterByMale;
  final bool isFilteringByFemale;
  final String textInitialValue;
  final bool isFilteringByMale;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    final headerBackgroundColor = darkMode ? Colors.black : Colors.white;
    final elementsColor = darkMode ? Colors.white : Colors.black;

    return Container(
      color: headerBackgroundColor,
      child: Column(
        children: [
          InputSearch(
            hintText: 'Buscar pessoa ou funcão',
            initialValue: textInitialValue,
            search: onFilterByText,
            color: elementsColor,
          ),
          Row(
            children: [
              InlineCheckbox(
                activeColor: Colors.blue,
                borderColor: elementsColor,
                onPressed: onFilterByMale,
                textColor: elementsColor,
                value: isFilteringByMale,
                text: "Male",
              ),
              InlineCheckbox(
                value: isFilteringByFemale,
                onPressed: onFilterByFemale,
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
