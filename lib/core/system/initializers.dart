import 'package:tree_view/core/appearence/controller/dependency_injection.dart';
import 'package:tree_view/features/assets/controller/dependency_injection.dart';
import 'package:tree_view/core/models/dependency_injection.dart';

class SystemInitializer {
  static void initDependencies() {
    _initializeDependencies();
  }

  static void _initializeDependencies() {
    final List<DependencyInjection> dependencies = [
      AppearenceControllerDependency(),
      AssetsControllerDependency(),
    ];

    for (var dependency in dependencies) {
      dependency.init();
    }
  }
}
