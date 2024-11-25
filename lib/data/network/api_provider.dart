import 'package:dio/dio.dart';

class ApiProvider {
  static const _productionEndpoint = 'https://dummyjson.com';
  static const endpoint = _productionEndpoint;

  final Dio _dio;

  ApiProvider({required Dio dio}) : _dio = dio {
    _initBaseOptions();
  }

  void _initBaseOptions() {
    _dio.options = BaseOptions(baseUrl: endpoint);
  }

  Future<T?> get<T>(
    String path,
  ) async {
    final response = await _dio.get<T>(endpoint + path);

    return response.data;
  }
}
