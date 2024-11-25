part of 'item_page_cubit.dart';

class ItemPageState {
  Product product;
  int productsCount;

  ItemPageState({
    required this.product,
    required this.productsCount,
  });

  ItemPageState newState({
    Product? product,
    int? productsCount,
  }) {
    return ItemPageState(
      product: product ?? this.product,
      productsCount: productsCount ?? this.productsCount,
    );
  }

  List<Object?> get props => [
        product,
        productsCount,
      ];
}
