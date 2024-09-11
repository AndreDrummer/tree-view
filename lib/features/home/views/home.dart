import 'package:tree_view/features/home/widgets/company_tile.dart';
import 'package:tree_view/core/widgets/dark_mode_button.dart';
import 'package:tree_view/core/constants/graphic_assets.dart';
import 'package:tree_view/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(ImageAssets.logo.name),
        actions: const [DarkModeButton()],
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: List.generate(
              3,
              (i) {
                return CompanyTile(
                  onTap: () => Get.toNamed(Routes.assetsView),
                  title: "Jaguar Unit",
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
