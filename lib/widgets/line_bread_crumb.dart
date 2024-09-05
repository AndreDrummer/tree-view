import 'package:flutter/material.dart';

class LineBreadCrumb extends StatelessWidget {
  const LineBreadCrumb(this.lineHeight, {super.key});

  final int lineHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24),
      width: 1,
      height: lineHeight.toDouble(),
      color: Colors.white,
    );
  }
}
