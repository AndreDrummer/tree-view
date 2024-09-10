import 'package:tree_view/features/assets/controller/assets_controller.dart';
import 'package:tree_view/core/models/dependency_injection.dart';
import 'package:get/get.dart';

class AssetsControllerDependency extends DependencyInjection {
  @override
  void init() {
    Get.lazyPut(() => AssetsController());
  }
}
