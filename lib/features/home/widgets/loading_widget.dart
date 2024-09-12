import 'package:flutter/material.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';
import 'package:get/get.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.feedbackText});

  final String? feedbackText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 16,
          width: 16,
          child: CircularProgressIndicator(
            backgroundColor: AppTheme.light,
            strokeWidth: 1.5,
          ),
        ),
        const SizedBox(height: 8.0),
        if (feedbackText != null)
          Text(
            style: context.theme.textTheme.bodySmall,
            feedbackText!,
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
