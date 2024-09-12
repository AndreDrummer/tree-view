import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/features/home/widgets/loading_widget.dart';
import 'package:tree_view/features/home/widgets/company_tile.dart';
import 'package:tree_view/core/widgets/dark_mode_button.dart';
import 'package:tree_view/core/constants/graphic_assets.dart';
import 'package:tree_view/core/widgets/screen_blur.dart';
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
              final AssetsController assetsController = Get.find();
              final HomeController homeController = Get.find();
              return Stack(
                children: [
                  Column(
                    children: homeController.companies.map(
                      (company) {
                        return CompanyTile(
                          onTap: () async {
                            await assetsController.loadCompanyItems(company);
                            Get.toNamed(Routes.assetsView);
                          },
                          title: company.name,
                        );
                      },
                    ).toList(),
                  ),
                  Visibility(
                    visible: assetsController.isLoading,
                    child: ScreenBlur(
                      child: LoadingWidget(
                        feedbackText: assetsController.feedbackText,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
