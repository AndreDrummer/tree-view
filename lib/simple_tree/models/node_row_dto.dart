import 'package:flutter/material.dart';

class NodeRowConfig {
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final double? suffixIconSize;
  final Color? suffixIconColor;
  final String? prefixIcon;
  final IconData? suffixIcon;
  final String title;

  NodeRowConfig({
    required this.title,
    this.prefixIconColor,
    this.suffixIconColor,
    this.prefixIconSize,
    this.suffixIconSize,
    this.prefixIcon,
    this.suffixIcon,
  });
}
