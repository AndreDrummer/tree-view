import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleErrorWidget extends StatelessWidget {
  const SimpleErrorWidget({
    super.key,
    required this.errorMessage,
    required this.textColor,
    required this.iconColor,
    required this.icon,
    this.retryAction,
    this.retryMessage,
  });

  final void Function()? retryAction;
  final String? retryMessage;
  final String errorMessage;
  final Color textColor;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                color: textColor,
              ),
            ),
          ),
          Visibility(
            visible: retryAction != null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: retryAction,
                child: Text(
                  retryMessage ?? "Reload",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
