import 'package:test_products_and_cart/data/models/product.dart';

class CartPosition {
  int quantity;
  final Product product;

  CartPosition(this.product, this.quantity);

  CartPosition.one(this.product) : quantity = 1;

  @override
  operator ==(other) => other is CartPosition && other.product == product;

  @override
  int get hashCode => Object.hash(quantity, product);

  @override
  String toString() {
    return ' | ${product.name} (${product.price}): ${product.description?.substring(0, 10) ?? '-'} --- $quantity unit(s)';
  }
}
