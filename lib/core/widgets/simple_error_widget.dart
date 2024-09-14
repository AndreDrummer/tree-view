import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_view/core/appearence/controller/appearence_controller.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';

class SimpleErrorWidget extends StatelessWidget {
  const SimpleErrorWidget({
    super.key,
    required this.errorMessage,
    required this.icon,
    this.retryAction,
    this.retryMessage,
  });

  final void Function()? retryAction;
  final String? retryMessage;
  final String errorMessage;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              final AppearenceController controller = Get.find();
              return Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: controller.isDarkModeON
                      ? AppTheme.light
                      : AppTheme.primaryColor,
                ),
              );
            }),
          ),
          Visibility(
            visible: retryAction != null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: retryAction,
                child: Text(
                  retryMessage ?? "Recarregar",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
