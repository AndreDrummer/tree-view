import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';

class CompanyTile extends StatelessWidget {
  const CompanyTile({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      height: 76,
      width: 317,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        color: context.theme.colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(width: 24),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.business_rounded, color: AppTheme.light1),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 20, color: AppTheme.light1),
            ),
          ],
        ),
      ),
    );
  }
}
