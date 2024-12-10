import 'package:dio/dio.dart';

/// Провайдер для работы с API.
///
/// Этот класс реализует методы для инициализации и выполнения запросов к API.
class ApiProvider {
  static const _productionEndpoint = 'https://dummyjson.com';
  static const endpoint = _productionEndpoint;

  final Dio _dio;

  /// Конструктор класса [ApiProvider].
  ///
  /// Принимает [dio] для работы с запросами и инициализирует базовые настройки.
  ApiProvider({required Dio dio}) : _dio = dio {
    _initBaseOptions();
  }

  /// Инициализирует базовые настройки для запросов.
  void _initBaseOptions() {
    _dio.options = BaseOptions(baseUrl: endpoint);
  }

  /// Выполняет GET-запрос к указанному [path].
  ///
  /// Возвращает ответ [T] или null, если запрос не удался.
  Future<T?> get<T>(
    String path,
  ) async {
    final response = await _dio.get<T>(endpoint + path);

    return response.data;
  }
}
