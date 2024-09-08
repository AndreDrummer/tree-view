import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeController, _) {
        final bool darkModeIsON = homeController.isDarkModeON;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "TreeView - App",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 18,
                  ),
                ),
              ),
              IconButton(
                onPressed: homeController.toggleAppearenceMode,
                icon: Icon(
                  darkModeIsON ? Icons.light_mode : Icons.dark_mode,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
