import 'package:test_products_and_cart/data/models/product.dart';
import 'package:test_products_and_cart/data/network/api_provider.dart';

class ProductRepositoryImpl {
  final ApiProvider _apiProvider;

  ProductRepositoryImpl({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

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
}
