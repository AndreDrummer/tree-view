import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
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
                CheckboxListTile(
                  activeColor: Colors.blue,
                  side: BorderSide(color: color),
                  value: controller.genderTypeFilter == controller.male,
                  onChanged: (value) {
                    controller.filterByMaleGender();
                  },
                  title: Text(
                    "Male",
                    style: TextStyle(color: color, fontSize: 18),
                  ),
                ),
                CheckboxListTile(
                  activeColor: Colors.pink,
                  side: BorderSide(color: color),
                  value: controller.genderTypeFilter == controller.female,
                  onChanged: (value) {
                    controller.filterByFemaleGender();
                  },
                  title: Text(
                    "Female",
                    style: TextStyle(color: color, fontSize: 18),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
