import 'package:flutter/foundation.dart';
import 'package:tree_view/core/models/location.dart';
import 'package:tree_view/core/models/company.dart';
import 'package:tree_view/core/models/asset.dart';
import 'package:get/get.dart';

class HttpProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = Company.fromList;
    httpClient.baseUrl = 'https://fake-api.tractian.com';

    print("PROVIDER INITIAL ${httpClient.baseUrl}");
  }

  Future<Response<List<Company>>> getCompanies(String urlPath) {
    try {
      httpClient.defaultDecoder = Company.fromList;
      return get(urlPath);
    } catch (e, stack) {
      debugPrint("Exception $e: $stack");

      rethrow;
    }
  }

  Future<Response<List<Location>>> getLocations(String urlPath) {
    try {
      httpClient.defaultDecoder = Location.fromList;
      return get(urlPath);
    } catch (e, stack) {
      debugPrint("Exception $e: $stack");

      rethrow;
    }
  }

  Future<Response<List<Asset>>> getAssets(String urlPath) {
    try {
      httpClient.defaultDecoder = Asset.fromList;
      return get(urlPath);
    } catch (e, stack) {
      debugPrint("Exception $e: $stack");

      rethrow;
    }
  }
}
