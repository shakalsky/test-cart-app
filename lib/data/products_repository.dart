import 'package:test_products_and_cart/data/models/product.dart';
import 'package:test_products_and_cart/data/network/api_provider.dart';
import 'package:test_products_and_cart/data/network/hive_provider.dart';
import 'package:test_products_and_cart/presentation/models/cart_position.dart';

/// Репозиторий для работы с продуктами.
///
/// Этот класс реализует методы для получения списка продуктов,
/// работы с корзиной и сохранения продуктов.
class ProductRepositoryImpl {
  final ApiProvider _apiProvider;
  final HiveProvider _hiveProvider;

  /// Конструктор класса [ProductRepositoryImpl].
  ///
  /// Принимает [apiProvider] для работы с API и [hiveProvider] для работы с локальным хранилищем.
  ProductRepositoryImpl({
    required ApiProvider apiProvider,
    required HiveProvider hiveProvider,
  })  : _apiProvider = apiProvider,
        _hiveProvider = hiveProvider;

  /// Получает список продуктов с сервера.
  ///
  /// Возвращает список объектов [Product].
  /// Если ответ от сервера пустой или не является картой, возвращает пустой список.
  Future<List<Product>> fetchProductsList() async {
    final response = await _apiProvider.get(
      '/products',
    );
    final List<Product> productsList;
    if (response == null || response is! Map<String, dynamic>) {
      productsList = [];
    } else {
      productsList = (response['products'] as List? ?? [])
          .map((e) => Product.fromJson(e))
          .whereType<Product>()
          .toList();
    }

    return productsList;
  }

  /// Получает список продуктов в корзине.
  ///
  /// Возвращает список объектов [CartPosition], которые содержат продукт и его количество.
  List<CartPosition> getCartProducts() {
    return _hiveProvider
        .getAllValues()
        .map((e) => CartPosition(Product.fromMapObject(e).$1, Product.fromMapObject(e).$2))
        .toList();
  }

  /// Удаляет все продукты из корзины.
  void deleteCartProducts() {
    _hiveProvider.deleteAll();
  }

  /// Сохраняет продукт в корзину.
  ///
  /// Принимает объект [CartPosition], который содержит продукт и его количество.
  void saveProduct(CartPosition position) {
    _hiveProvider.saveToBox(
      position.product.id.toString(),
      position.product.toMapObject(position.quantity),
    );
  }
}
