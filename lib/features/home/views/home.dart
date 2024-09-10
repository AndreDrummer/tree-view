import 'package:flutter/material.dart';
import 'package:tree_view/features/assets/views/asset_view.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.darkMode});

  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkMode ? Colors.black : Colors.white,
        body: const AssetsView(),
      ),
    );
  }
}
