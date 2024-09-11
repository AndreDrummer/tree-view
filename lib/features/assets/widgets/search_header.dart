import 'package:tree_view/features/assets/widgets/inline_checkbox.dart';
import 'package:tree_view/features/assets/widgets/input_search.dart';
import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({
    super.key,
    this.darkMode = true,
    this.scrollFunction,
    this.onFilterByText,
    this.onFilterByEnergy,
    this.onFilterByVibration,
    this.isFilteringByEnergy = false,
    this.isFilteringByVibration = false,
    required this.textInitialValue,
  });
  final Function(String text)? onFilterByText;
  final Function(bool)? scrollFunction;
  final Function()? onFilterByEnergy;
  final Function()? onFilterByVibration;
  final bool isFilteringByEnergy;
  final String textInitialValue;
  final bool isFilteringByVibration;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    final headerBackgroundColor = darkMode ? Colors.black : Colors.white;
    final elementsColor = darkMode ? Colors.white : Colors.black;

    return Container(
      color: headerBackgroundColor,
      child: Column(
        children: [
          Row(
            children: [
              InlineCheckbox(
                value: isFilteringByEnergy,
                onPressed: onFilterByEnergy,
                activeColor: Colors.greenAccent,
                borderColor: elementsColor,
                textColor: elementsColor,
                text: "Sensor de Energia",
              ),
              InlineCheckbox(
                activeColor: Colors.redAccent,
                borderColor: elementsColor,
                onPressed: onFilterByVibration,
                textColor: elementsColor,
                value: isFilteringByVibration,
                text: "Crítico",
              ),
            ],
          ),
          InputSearch(
            hintText: 'Buscar Ativo ou local',
            initialValue: textInitialValue,
            search: onFilterByText,
            color: elementsColor,
          ),
        ],
      ),
    );
  }
}
