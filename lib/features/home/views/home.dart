import 'package:tree_view/features/home/controller/home_controller.dart';
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
          child: Obx(
            () {
              final HomeController homeController = Get.find();
              return Column(
                children: homeController.companies.map(
                  (company) {
                    return CompanyTile(
                      onTap: () => Get.toNamed(Routes.assetsView),
                      title: company.name,
                    );
                  },
                ).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
