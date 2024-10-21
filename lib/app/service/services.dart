import 'package:getx_template/app/core/utils/parser.dart';
import 'package:getx_template/app/entity/product_list.dart';

import '/app/core/exporter.dart';
import 'client/api_options.dart';
import 'client/rest_client.dart';

class Services {
  factory Services() => instance;

  Services._privateConstructor();

  static final Services instance = Services._privateConstructor();

  final pref = SessionManager();

  final dio = RestClient(
    baseUrl: BuildConfig.instance.config.baseUrl,
    token: '',
  );

  Map<String, dynamic> _buildHeader() {
    return {};
  }

  void printError(
    dynamic e,
    dynamic s,
    String endPoint,
  ) {
    if (kDebugMode) {
      print('Error: $e');
      print('Stack Trace: $s');
    }
  }

  // Service methods

  Future<bool?> login({
    required String username,
    required String password,
  }) async {
    const endPoint = 'login';
    try {
      final data = {
        'username': username,
        'password': password,
      };

      final response = await dio.post(
        APIType.public,
        endPoint,
        data,
        headers: _buildHeader(),
      );

      final responseData = response.data as Map<String, dynamic>?;
      if (responseData == null || responseData['error'] != null) {
        return false;
      }

      return true;
    } catch (e, s) {
      printError(e, s, endPoint);
      return false;
    }
  }

  Future<void> register({
    required String username,
    required String password,
    required String email,
  }) async {
    const endPoint = 'register';
    try {
      final data = {
        'username': username,
        'password': password,
        'email': email,
      };

      final response = await dio.post(
        APIType.public,
        endPoint,
        data,
        headers: _buildHeader(),
      );

      final responseData = response.data as Map<String, dynamic>?;
      if (responseData == null || responseData['error'] != null) {
        throw Exception('Failed to register');
      }
    } catch (e, s) {
      printError(e, s, endPoint);
      rethrow;
    }
  }

  Future<List<ProductList>?> getProducts() async {
    const endPoint = 'products?limit=20';
    try {
      final response = await dio.get(
        APIType.public,
        endPoint,
        headers: _buildHeader(),
      );

      final responseData = response.data as List?;
      if (responseData == null) return null;
      return parseList(
        list: responseData,
        fromJson: ProductList.fromJson,
      );
    } catch (e, s) {
      printError(e, s, endPoint);
      rethrow;
    }
  }
}
