import 'package:test_products_and_cart/data/products_repository.dart';
import 'package:test_products_and_cart/presentation/models/cart_position.dart';
import 'package:test_products_and_cart/presentation/shared/shared_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Кубит для управления выбранными продуктами.
///
/// Этот класс реализует методы для управления продуктами в корзине, включая
/// добавление, удаление, увеличение и уменьшение количества товара в корзине.
class SelectedProductsSharedCubit extends Cubit<SelectedProductsState> {
  final ProductRepositoryImpl _productRepository;

  /// Конструктор класса [SelectedProductsSharedCubit].
  ///
  /// Принимает [productRepository] для взаимодействия с репозиторием продуктов.
  SelectedProductsSharedCubit({required ProductRepositoryImpl productRepository})
      : _productRepository = productRepository,
        super(SelectedProductsState(productPositions: []));

  /// Возвращает список продуктов в корзине.
  List<CartPosition> get productsInCart => state.productPositions;

  /// Получает сохраненные продукты из репозитория и обновляет состояние.
  void getSavedProducts() {
    emit(
      state.newState(productPositions: _productRepository.getCartProducts()),
    );
  }

  /// Добавляет продукт в корзину.
  ///
  /// Принимает [product] - позицию товара в корзине.
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

  /// Удаляет продукт из корзины.
  ///
  /// Принимает [productPosition] - позицию товара в корзине.
  void deleteProduct(CartPosition productPosition) {
    final updatedProducts = state.productPositions;
    updatedProducts.removeWhere((i) => i == productPosition);
    emit(
      state.newState(productPositions: [...updatedProducts]),
    );
  }

  /// Очищает все продукты из корзины.
  void deleteAllProducts() {
    _productRepository.deleteCartProducts();
    emit(
      state.newState(productPositions: []),
    );
  }

  /// Увеличивает количество товара в корзине.
  ///
  /// Принимает [productPosition] - позицию товара в корзине.
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

  /// Уменьшает количество товара в корзине.
  ///
  /// Принимает [productPosition] - позицию товара в корзине.
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
