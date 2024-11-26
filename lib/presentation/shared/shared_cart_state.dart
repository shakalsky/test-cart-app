import 'package:test_products_and_cart/presentation/models/cart_position.dart';

class SelectedProductsState {
  final List<CartPosition> productPositions;

  SelectedProductsState({required this.productPositions});

  SelectedProductsState newState({List<CartPosition>? productPositions}) {
    return SelectedProductsState(
      productPositions: productPositions ?? this.productPositions,
    );
  }

  List<Object?> get props => [
        productPositions,
      ];
}
