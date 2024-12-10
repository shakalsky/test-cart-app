import 'package:test_products_and_cart/data/models/product.dart';
import 'package:test_products_and_cart/data/network/api_provider.dart';
import 'package:test_products_and_cart/data/network/hive_provider.dart';
import 'package:test_products_and_cart/presentation/models/cart_position.dart';

class ProductRepositoryImpl {
  final ApiProvider _apiProvider;
  final HiveProvider _hiveProvider;

  ProductRepositoryImpl({
    required ApiProvider apiProvider,
    required HiveProvider hiveProvider,
  })  : _apiProvider = apiProvider,
        _hiveProvider = hiveProvider;

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

  List<CartPosition> getCartProducts() {
    return _hiveProvider
        .getAllValues()
        .map((e) => CartPosition(Product.fromMapObject(e).$1, Product.fromMapObject(e).$2))
        .toList();
  }

  void deleteCartProducts() {
    _hiveProvider.deleteAll();
  }

  void saveProduct(CartPosition position) {
    _hiveProvider.saveToBox(
      position.product.id.toString(),
      position.product.toMapObject(position.quantity),
    );
  }
}
