import 'package:tree_view/features/assets/views/asset_view.dart';
import 'package:tree_view/core/system/views/splashscreen.dart';
import 'package:tree_view/features/home/views/home.dart';
import 'package:tree_view/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return createCustomTransition(const Splashscreen());
      case Routes.home:
        return createCustomTransition(const Home());
      case Routes.assetsView:
        return createCustomTransition(const AssetsView());
    }
    return null;
  }

  static PageRouteBuilder createCustomTransition(Widget screen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      reverseTransitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
          parent: animation,
        ));

        final slideOutAnimation = Tween(
          begin: Offset.zero,
          end: const Offset(-0.3, 0.0),
        ).animate(CurvedAnimation(
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
          parent: secondaryAnimation,
        ));

        return SlideTransition(
          position: slideAnimation,
          child: SlideTransition(
            position: slideOutAnimation,
            child: child,
          ),
        );
      },
    );
  }
}
