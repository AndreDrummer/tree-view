import 'package:tree_view/core/models/location.dart';
import 'package:tree_view/core/models/company.dart';
import 'package:tree_view/core/models/asset.dart';
import 'package:get/get.dart';

class HttpProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = Company.fromJson;
    httpClient.baseUrl = 'fake-api.tractian.com';
  }

  Future<Response> getCompanies(String urlPath) {
    httpClient.defaultDecoder = Company.fromJson;
    return get(urlPath);
  }

  Future<Response> getLocations(String urlPath) {
    httpClient.defaultDecoder = Location.fromJson;
    return get(urlPath);
  }

  Future<Response> getAssets(String urlPath) {
    httpClient.defaultDecoder = Asset.fromJson;
    return get(urlPath);
  }
}
