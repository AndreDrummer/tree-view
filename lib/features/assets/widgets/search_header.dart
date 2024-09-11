import 'package:tree_view/features/assets/widgets/inline_checkbox.dart';
import 'package:tree_view/features/assets/widgets/input_search.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({
    super.key,
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

  @override
  Widget build(BuildContext context) {
    final elementsColor =
        Get.isDarkMode ? AppTheme.light : AppTheme.primaryColor;

    return Material(
      child: Container(
        color: Get.isDarkMode ? AppTheme.primaryColor : AppTheme.light,
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
      ),
    );
  }
}
