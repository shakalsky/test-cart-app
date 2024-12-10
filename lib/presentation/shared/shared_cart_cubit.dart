import 'package:test_products_and_cart/data/products_repository.dart';
import 'package:test_products_and_cart/presentation/models/cart_position.dart';
import 'package:test_products_and_cart/presentation/shared/shared_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedProductsSharedCubit extends Cubit<SelectedProductsState> {
  final ProductRepositoryImpl _productRepository;

  SelectedProductsSharedCubit({required ProductRepositoryImpl productRepository})
      : _productRepository = productRepository,
        super(SelectedProductsState(productPositions: []));

  List<CartPosition> get productsInCart => state.productPositions;

  void getSavedProducts() {
    emit(
      state.newState(productPositions: _productRepository.getCartProducts()),
    );
  }

  void addProduct(CartPosition product) {
    if (state.productPositions.contains(product)) {
      incrementItemCount(product);
    } else {
      _productRepository.saveProduct(product);
      emit(
        state.newState(productPositions: [...state.productPositions, product]),
      );
    }
  }

  void deleteProduct(CartPosition productPosition) {
    final updatedProducts = state.productPositions;
    updatedProducts.removeWhere((i) => i == productPosition);
    emit(
      state.newState(productPositions: [...updatedProducts]),
    );
  }

  void deleteAllProducts() {
    _productRepository.deleteCartProducts();
    emit(
      state.newState(productPositions: []),
    );
  }

  void incrementItemCount(CartPosition productPosition) {
    final int itemIndex = (state.productPositions.indexWhere((p) => p == productPosition));
    final List<CartPosition> newCollection = state.productPositions;
    final CartPosition updatedItem = state.productPositions[itemIndex];
    updatedItem.quantity++;
    newCollection[itemIndex] = updatedItem;

    _productRepository.saveProduct(updatedItem);
    emit(
      state.newState(productPositions: [...newCollection]),
    );
  }

  void decrementItemCount(CartPosition productPosition) {
    final int itemIndex = (state.productPositions.indexWhere((p) => p == productPosition));
    if (state.productPositions[itemIndex].quantity > 1) {
      final List<CartPosition> newCollection = state.productPositions;
      final CartPosition updatedItem = state.productPositions[itemIndex];
      updatedItem.quantity--;
      newCollection[itemIndex] = updatedItem;

      _productRepository.saveProduct(updatedItem);
      emit(
        state.newState(productPositions: [...newCollection]),
      );
    }
  }
}
