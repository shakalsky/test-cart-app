import 'package:test_products_and_cart/data/models/product.dart';
import 'package:test_products_and_cart/data/shared/shared_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedProductsSharedCubit extends Cubit<SelectedProductsState> {
  SelectedProductsSharedCubit() : super(SelectedProductsState(products: []));

  get productsInCart => state.products;

  void addProduct(List<Product> product) {
    emit(state.newState(products: [...state.products, ...product]));
  }

  void deleteProduct(Product product) {
    final updatedProducts = state.products;
    updatedProducts.removeWhere((p) => p.name == product.name);
    emit(state.newState(products: [...updatedProducts]));
  }

  void incrementItemCount(Product item) {
    final newItem = state.products[(state.products.indexWhere((p) => p.name == item.name))];

    emit(state.newState(products: [...state.products, newItem]));
  }

  void decrementItemCount(Product item) {
    final newList = state.products;
    newList.removeAt((state.products.indexWhere((p) => p.name == item.name)));

    emit(state.newState(products: [...newList]));
  }

  void resetSelectedStories() => emit(state.newState(products: []));
}
