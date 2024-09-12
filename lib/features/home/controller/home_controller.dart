import 'package:get/get.dart';
import 'package:tree_view/core/http/endpoints.dart';
import 'package:tree_view/core/http/http_provider.dart';
import 'package:tree_view/core/models/company.dart';

class HomeController extends GetxController {
  final RxList<Company> _companies = <Company>[].obs;

  late HttpProvider _httpProvider;

  List<Company> get companies => _companies;

  @override
  void onInit() {
    _httpProvider = Get.find();
    super.onInit();
  }

  Future<void> loadCompanies() async {
    final response = await _httpProvider.getCompanies(Endpoints.companies);

    if (response.isOk) {
      _companies(response.body);
    }
  }
}
