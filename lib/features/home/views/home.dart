import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_view/core/appearence/controller/appearence_controller.dart';
import 'package:tree_view/core/widgets/custom_app_bar.dart';
import 'package:tree_view/features/assets/views/asset_view.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.darkMode});

  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        final AppearenceController appearence = Get.find();

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: darkMode ? Colors.black : Colors.white,
          body: Column(
            children: [
              CustomAppBar(
                onDarkModeChanged: appearence.toggleAppearenceMode,
                darkMode: appearence.isDarkModeON,
              ),
              const AssetsView(),
            ],
          ),
        );
      }),
    );
  }
}
