import 'package:flutter/material.dart';

class LineBreadCrumb extends StatelessWidget {
  const LineBreadCrumb(this.lineHeight, {super.key, this.elementColor});

  final Color? elementColor;
  final int lineHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24),
      width: 1,
      height: lineHeight.toDouble(),
      color: elementColor,
    );
  }
}
