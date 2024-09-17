import 'package:tree_view/core/appearence/controller/appearence_controller.dart';
import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/features/home/widgets/loading_widget.dart';
import 'package:tree_view/features/home/widgets/company_tile.dart';
import 'package:tree_view/core/widgets/simple_error_widget.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';
import 'package:tree_view/core/constants/graphic_assets.dart';
import 'package:tree_view/core/widgets/dark_mode_button.dart';
import 'package:tree_view/core/widgets/screen_blur.dart';
import 'package:tree_view/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(ImageAssets.logo.name),
          actions: const [DarkModeButton()],
          automaticallyImplyLeading: false,
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
                    Visibility(
                      visible: homeController.companies.isNotEmpty,
                      replacement: _errorWidget(),
                      child: ListView(
                        children: homeController.companies.map(
                          (company) {
                            return CompanyTile(
                              onTap: () async {
                                await assetsController
                                    .loadCompanyItems(company);
                                Get.toNamed(Routes.assetsView);
                              },
                              title: company.name,
                            );
                          },
                        ).toList(),
                      ),
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
      ),
    );
  }

  Widget _errorWidget() {
    return Obx(() {
      final AppearenceController appearenceController = Get.find();
      return SimpleErrorWidget(
        retryAction: () {
          Get.offNamedUntil(
            Routes.root,
            ModalRoute.withName(Routes.root),
          );
        },
        errorMessage: "Oh, looks like there's nothing here.",
        retryMessage: "Restart",
        iconColor: appearenceController.isDarkModeON
            ? AppTheme.light
            : AppTheme.primaryColor,
        textColor: appearenceController.isDarkModeON
            ? AppTheme.light
            : AppTheme.primaryColor,
        icon: Icons.air,
      );
    });
  }
}
