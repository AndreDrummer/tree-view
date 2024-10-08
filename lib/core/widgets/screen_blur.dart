import 'package:flutter/material.dart';

class ScreenBlur extends StatelessWidget {
  const ScreenBlur({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.black.withOpacity(.65),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
