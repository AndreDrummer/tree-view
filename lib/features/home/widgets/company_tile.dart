import 'package:tree_view/core/appearence/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyTile extends StatelessWidget {
  const CompanyTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  final Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        alignment: Alignment.center,
        height: 76,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: context.theme.colorScheme.onPrimaryContainer,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(width: 24),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.business_rounded, color: AppTheme.light),
              ),
              Text(
                title,
                style: context.theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
