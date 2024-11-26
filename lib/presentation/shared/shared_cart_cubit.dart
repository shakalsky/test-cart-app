import 'package:test_products_and_cart/presentation/models/cart_position.dart';
import 'package:test_products_and_cart/presentation/shared/shared_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedProductsSharedCubit extends Cubit<SelectedProductsState> {
  SelectedProductsSharedCubit() : super(SelectedProductsState(productPositions: []));

  List<CartPosition> get productsInCart => state.productPositions;

  void addProduct(CartPosition product) {
    emit(
      state.newState(productPositions: [...state.productPositions, product]),
    );
  }

  void deleteProduct(CartPosition productPosition) {
    final updatedProducts = state.productPositions;
    updatedProducts.removeWhere((i) => i == productPosition);
    emit(
      state.newState(productPositions: [...updatedProducts]),
    );
  }

  void incrementItemCount(CartPosition productPosition) {
    final int itemIndex = (state.productPositions.indexWhere((p) => p == productPosition));
    final List<CartPosition> newCollection = state.productPositions;
    final CartPosition updatedItem = state.productPositions[itemIndex];
    updatedItem.quantity++;
    newCollection[itemIndex] = updatedItem;
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
      emit(
        state.newState(productPositions: [...newCollection]),
      );
    }
  }
}
