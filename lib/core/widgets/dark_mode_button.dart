import 'package:tree_view/core/appearence/controller/appearence_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final AppearenceController appearenceController = Get.find();

      return IconButton(
        onPressed: appearenceController.toggleAppearenceMode,
        icon: Icon(
          appearenceController.isDarkModeON
              ? Icons.light_mode
              : Icons.dark_mode,
        ),
      );
    });
  }
}
