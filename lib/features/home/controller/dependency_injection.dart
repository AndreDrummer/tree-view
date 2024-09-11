import 'package:tree_view/features/home/controller/home_controller.dart';
import 'package:tree_view/core/models/dependency_injection.dart';
import 'package:get/get.dart';

class HomeControllerDependency extends DependencyInjection {
  @override
  void init() {
    Get.lazyPut(() => HomeController());
  }
}
