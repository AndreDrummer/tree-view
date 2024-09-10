import 'package:tree_view/core/appearence/controller/appearence_controller.dart';
import 'package:tree_view/core/models/dependency_injection.dart';
import 'package:get/get.dart';

class AppearenceControllerDependency extends DependencyInjection {
  @override
  void init() {
    Get.lazyPut(() => AppearenceController());
  }
}
