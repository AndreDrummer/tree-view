import 'package:flutter/material.dart';

class InlineCheckbox extends StatelessWidget {
  const InlineCheckbox({
    super.key,
    this.onPressed,
    required this.borderColor,
    required this.activeColor,
    required this.textColor,
    required this.text,
    this.value,
  });

  final void Function()? onPressed;
  final Color borderColor;
  final Color activeColor;
  final Color textColor;
  final String text;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 18),
          ),
        ),
        Checkbox.adaptive(
          side: BorderSide(color: borderColor),
          activeColor: activeColor,
          value: value,
          onChanged: (_) {
            onPressed?.call();
          },
        ),
      ],
    );
  }
}
