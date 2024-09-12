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
  final bool isFilteringByVibration;
  final bool isFilteringByEnergy;
  final String textInitialValue;

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ButtonFiler(
                    icon: Icons.flash_on_outlined,
                    active: isFilteringByEnergy,
                    text: "Sensor de Energia",
                    onTap: onFilterByEnergy,
                  ),
                ),
                Expanded(
                  child: ButtonFiler(
                    active: isFilteringByVibration,
                    onTap: onFilterByVibration,
                    icon: Icons.info_outline,
                    text: "Crítico",
                  ),
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

class ButtonFiler extends StatelessWidget {
  const ButtonFiler({
    super.key,
    this.onTap,
    required this.active,
    required this.icon,
    required this.text,
  });

  final Function()? onTap;
  final IconData icon;
  final bool active;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 100,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: Colors.grey,
          ),
          color: active ? AppTheme.secondaryColor : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(
                icon,
                color: active ? AppTheme.light : Colors.grey,
                size: 16,
              ),
            ),
            Text(
              text,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: active ? AppTheme.light : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
