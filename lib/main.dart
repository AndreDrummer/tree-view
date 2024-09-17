import 'package:tree_view/core/appearence/controller/appearence_controller.dart';
import 'package:tree_view/core/appearence/theme/app_theme.dart';
import 'package:tree_view/core/widgets/restart_widget.dart';
import 'package:tree_view/core/system/initializers.dart';
import 'package:tree_view/core/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  SystemInitializer.initDependencies();

  runApp(const RestartWidget(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apprearenceController = Get.find<AppearenceController>();
    apprearenceController.setSystemThemeMode();

    return GetMaterialApp(
      onGenerateRoute: RouterGenerator.onGenerateRoute,
      themeMode:
          apprearenceController.isDarkModeON ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkMode,
      theme: AppTheme.lightMode,
    );
  }
}
