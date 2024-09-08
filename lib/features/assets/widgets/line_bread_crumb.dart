import 'package:flutter/material.dart';

class LineBreadCrumb extends StatelessWidget {
  const LineBreadCrumb(this.lineHeight,
      {super.key, required this.darkModeIsON});

  final bool darkModeIsON;
  final int lineHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24),
      width: 1,
      height: lineHeight.toDouble(),
      color: darkModeIsON ? Colors.white24 : Colors.black12,
    );
  }
}
