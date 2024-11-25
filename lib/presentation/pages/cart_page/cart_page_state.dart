part of 'cart_page_cubit.dart';

class CartPageState {
  List<Product> addedProducts;

  CartPageState({
    required this.addedProducts,
  });

  CartPageState newState({
    List<Product>? addedProducts,
  }) {
    return CartPageState(
      addedProducts: addedProducts ?? this.addedProducts,
    );
  }

  List<Object?> get props => [
        addedProducts,
      ];
}
