import 'package:tree_view/core/http/http_provider.dart';
import 'package:tree_view/core/http/endpoints.dart';
import 'package:tree_view/core/models/company.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxList<Company> _companies = <Company>[].obs;
  final RxBool _hasConnectionError = false.obs;
  final RxBool _hasServerError = false.obs;
  final RxBool _hasError = false.obs;

  bool get hasConnectionError => _hasConnectionError.value;
  bool get hasServerError => _hasServerError.value;
  bool get hasError => _hasError.value;

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
      _resetErrorStatus();
    } else {
      _handleErrorResponse(response);
    }
  }

  void _handleErrorResponse(Response response) {
    _hasConnectionError(response.status.connectionError);
    _hasServerError(response.status.isServerError);
    _hasError(response.status.hasError);
  }

  void _resetErrorStatus() {
    _hasConnectionError(false);
    _hasServerError(false);
    _hasError(false);
  }
}
