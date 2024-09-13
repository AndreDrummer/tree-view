import 'package:flutter/material.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';

class ProgressLoading extends StatelessWidget {
  const ProgressLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16,
      width: 16,
      child: CircularProgressIndicator(
        color: AppTheme.secondaryColor,
        backgroundColor: AppTheme.light,
        strokeWidth: 1.5,
      ),
    );
  }
}
