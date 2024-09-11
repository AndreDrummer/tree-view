import 'package:flutter/material.dart';

class ScreenBlur extends StatelessWidget {
  const ScreenBlur({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.black.withOpacity(.65),
      ),
    );
  }
}
