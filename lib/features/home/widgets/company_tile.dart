import 'package:tree_view/core/constants/graphic_assets.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  SVGAssets.hierarchy.name,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppTheme.light,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Text(title, style: context.theme.textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
