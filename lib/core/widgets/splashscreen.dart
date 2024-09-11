import 'package:tree_view/core/constants/graphic_assets.dart';
import 'package:tree_view/core/widgets/background_video.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:tree_view/core/widgets/screen_blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  Widget welcomeText() {
    return const Text(
      "Olá, seja bem vindo a",
      style: TextStyle(
        fontSize: 32.0,
        fontFamily: 'Horizon',
      ),
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
      child: SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget roundingTexts() {
    return Center(
      child: DefaultTextStyle(
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16.0,
          fontFamily: 'Horizon',
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundVideo(),
          const ScreenBlur(),
          Center(
            child: Column(
              children: [
                SizedBox(height: Get.height / 2.5),
                welcomeText(),
                imageLogo(),
                loadingIndicator(),
                roundingTexts(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
