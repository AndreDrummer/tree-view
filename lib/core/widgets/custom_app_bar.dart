import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, required this.darkMode, this.onDarkModeChanged});

  final void Function()? onDarkModeChanged;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "TreeView - App",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 18,
              ),
            ),
          ),
          IconButton(
            onPressed: onDarkModeChanged,
            icon: Icon(
              darkMode ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          )
        ],
      ),
    );
  }
}
