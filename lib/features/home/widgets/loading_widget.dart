import 'package:flutter/material.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:tree_view/core/widgets/progress_loading.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.feedbackText});

  final String? feedbackText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ProgressLoading(),
        const SizedBox(height: 16.0),
        if (feedbackText != null)
          Text(
            style: context.theme.textTheme.bodySmall?.copyWith(
              color: AppTheme.light,
            ),
            feedbackText!,
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
