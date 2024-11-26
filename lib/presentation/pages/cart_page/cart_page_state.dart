part of 'cart_page_cubit.dart';

class CartPageState {
  List<CartPosition> addedProducts;

  CartPageState({
    required this.addedProducts,
  });

  CartPageState newState({
    List<CartPosition>? addedProducts,
  }) {
    return CartPageState(
      addedProducts: addedProducts ?? this.addedProducts,
    );
  }

  List<Object?> get props => [
        addedProducts,
      ];
}
