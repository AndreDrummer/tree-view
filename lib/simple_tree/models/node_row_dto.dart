import 'package:flutter/material.dart';

class NodeRowConfig {
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final double? suffixIconSize;
  final Color? suffixIconColor;
  final IconData? suffixIcon;
  final String? prefixIcon;
  final String title;

  NodeRowConfig({
    this.prefixIconColor,
    this.suffixIconColor,
    this.prefixIconSize,
    this.suffixIconSize,
    required this.title,
    this.prefixIcon,
    this.suffixIcon,
  });
}
