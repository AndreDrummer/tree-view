import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tree_view/features/assets/widgets/inline_checkbox.dart';
import 'package:tree_view/features/assets/widgets/input_search.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key, this.darkModeIsON = true});
  final bool darkModeIsON;

  @override
  Widget build(BuildContext context) {
    final color = darkModeIsON ? Colors.white : Colors.black;

    return Consumer<HomeController>(
      builder: (context, homeController, _) {
        return Consumer<AssetsController>(
          builder: (context, controller, _) {
            return Column(
              children: [
                InputSearch(color: color, onSubmitted: controller.searchByText),
                Row(
                  children: [
                    InlineCheckbox(
                      value: controller.genderTypeFilter == controller.male,
                      onPressed: controller.filterByMaleGender,
                      activeColor: Colors.blue,
                      borderColor: color,
                      textColor: color,
                      text: "Male",
                    ),
                    InlineCheckbox(
                      value: controller.genderTypeFilter == controller.female,
                      onPressed: controller.filterByFemaleGender,
                      activeColor: Colors.pink,
                      borderColor: color,
                      textColor: color,
                      text: "Female",
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
