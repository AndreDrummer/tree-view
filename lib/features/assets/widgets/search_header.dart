import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/features/assets/widgets/inline_checkbox.dart';
import 'package:tree_view/features/assets/widgets/input_search.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader(
      {super.key, this.darkModeIsON = true, this.scrollFunction});
  final Function(bool)? scrollFunction;
  final bool darkModeIsON;

  @override
  Widget build(BuildContext context) {
    final elementsColor = darkModeIsON ? Colors.white : Colors.black;
    final headerBackgroundColor = darkModeIsON ? Colors.black : Colors.white;

    return Consumer<HomeController>(
      builder: (context, homeController, _) {
        return Consumer<AssetsController>(
          builder: (context, controller, _) {
            return Container(
              color: headerBackgroundColor,
              child: Column(
                children: [
                  InputSearch(
                    search: controller.searchByText,
                    color: elementsColor,
                  ),
                  Row(
                    children: [
                      InlineCheckbox(
                        value: controller.genderTypeFilter == controller.male,
                        onPressed: () {
                          controller.filterByMaleGender();
                          scrollFunction?.call(controller.isFilteringByAny);
                        },
                        activeColor: Colors.blue,
                        borderColor: elementsColor,
                        textColor: elementsColor,
                        text: "Male",
                      ),
                      InlineCheckbox(
                        value: controller.genderTypeFilter == controller.female,
                        onPressed: () {
                          controller.filterByFemaleGender();
                          scrollFunction?.call(controller.isFilteringByAny);
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
          },
        );
      },
    );
  }
}
