import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/core/widgets/simple_error_widget.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';
import 'package:tree_view/core/constants/graphic_assets.dart';
import 'package:tree_view/core/widgets/progress_loading.dart';
import 'package:tree_view/core/widgets/background_video.dart';
import 'package:tree_view/core/widgets/restart_widget.dart';
import 'package:tree_view/core/widgets/async_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:tree_view/core/widgets/screen_blur.dart';
import 'package:tree_view/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  TextStyle _textStyle() {
    return const TextStyle(
      fontSize: 32.0,
      fontFamily: 'Horizon',
    );
  }

  Widget welcomeText() {
    return Text(
      "Hello, welcomings to",
      style: _textStyle(),
      textAlign: TextAlign.center,
    );
  }

  Widget imageLogo() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
      child: Image.asset(ImageAssets.logo.name),
    );
  }

  Widget loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: ProgressLoading(),
    );
  }

  Widget roundingTexts() {
    return Center(
      child: DefaultTextStyle(
        textAlign: TextAlign.center,
        style: _textStyle().copyWith(fontSize: 16),
        child: AnimatedTextKit(
          animatedTexts: [
            RotateAnimatedText('Please wait,'),
            RotateAnimatedText('Let\'s get started now'),
            RotateAnimatedText('It\'s great to have you here!'),
          ],
          repeatForever: true,
        ),
      ),
    );
  }

  Widget welcomeWidget() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: Get.height / 2.5),
          welcomeText(),
          imageLogo(),
        ],
      ),
    );
  }

  Widget loadingWidget() {
    return Column(
      children: [
        loadingIndicator(),
        roundingTexts(),
      ],
    );
  }

  Widget continueButton() {
    return ElevatedButton(
      onPressed: () {
        Get.offNamed(Routes.home);
      },
      child: Text(
        "Continue",
        style: _textStyle().copyWith(fontSize: 16),
      ),
    );
  }

  Widget errorStatusWidget(BuildContext context) {
    final HomeController homeController = Get.find();

    if (homeController.hasConnectionError) {
      return const SimpleErrorWidget(
        errorMessage: "Error connecting to the internet.",
        icon: Icons.wifi_off_rounded,
        iconColor: AppTheme.light,
        textColor: AppTheme.light,
      );
    } else if (homeController.hasServerError) {
      return const SimpleErrorWidget(
        errorMessage: "A server error occurred.\nTry again later!",
        iconColor: AppTheme.light,
        textColor: AppTheme.light,
        icon: Icons.public_off,
      );
    } else {
      return SimpleErrorWidget(
        errorMessage:
            "An unexpected error has occurred. Please restart the application or try again later!",
        retryAction: () {
          RestartWidget.restartApp(context);
          Get.offNamedUntil(
            Routes.root,
            ModalRoute.withName(Routes.root),
          );
        },
        iconColor: AppTheme.light,
        textColor: AppTheme.light,
        icon: Icons.error,
      );
    }
  }

  Widget onRequesFinish(BuildContext context) {
    if (!Get.find<HomeController>().hasError) {
      return continueButton();
    } else {
      return errorStatusWidget(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundVideo(),
          const ScreenBlur(),
          Column(
            children: [
              welcomeWidget(),
              AsyncWidget(
                future: Get.find<HomeController>().loadCompanies(),
                whenSuccessShow: onRequesFinish(context),
                whenErrorShow: const SizedBox.shrink(),
                whenLoadingShow: loadingWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
