import 'package:tree_view/core/routes/app_routes.dart';
import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/core/constants/graphic_assets.dart';
import 'package:tree_view/core/widgets/progress_loading.dart';
import 'package:tree_view/core/widgets/background_video.dart';
import 'package:tree_view/core/widgets/async_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:tree_view/core/widgets/screen_blur.dart';
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
      "Olá, seja bem vindo a",
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
            RotateAnimatedText('Por favor aguarde,'),
            RotateAnimatedText('Já vamos começar'),
            RotateAnimatedText('É muito bom ter você aqui!'),
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
        Get.toNamed(Routes.home);
      },
      child: Text(
        "Continuar",
        style: _textStyle().copyWith(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundVideo(),
          const ScreenBlur(),
          Column(
            children: [
              welcomeWidget(),
              AsyncWidget(
                whenErrorShow: const SizedBox.shrink(),
                future: homeController.loadCompanies(),
                whenLoadingShow: loadingWidget(),
                whenSuccessShow: continueButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
