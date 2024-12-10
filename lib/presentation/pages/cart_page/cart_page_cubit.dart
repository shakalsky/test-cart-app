import 'package:test_products_and_cart/presentation/shared/shared_cart_cubit.dart';
import 'package:test_products_and_cart/presentation/models/cart_position.dart';
import 'package:test_products_and_cart/presentation/state_manager/base_cubit.dart';

part 'cart_page_state.dart';

/// Кубит для страницы корзины.
///
/// Этот класс реализует методы для управления состоянием корзины, включая
/// увеличение и уменьшение количества товаров, удаление товаров и очистку корзины.
class CartPageCubit extends BaseCubit<CartPageState> {
  final SelectedProductsSharedCubit _selectedProductsSharedCubit;

  /// Конструктор класса [CartPageCubit].
  ///
  /// Принимает [selectedProductsSharedCubit] для управления товарами в корзине.
  CartPageCubit({required SelectedProductsSharedCubit selectedProductsSharedCubit})
      : _selectedProductsSharedCubit = selectedProductsSharedCubit,
        super(
          CartPageState(
            addedProducts: [],
          ),
        );

  /// Возвращает общую стоимость товаров в корзине с округлением до двух знаков после запятой.
  String get cartTotalPriceRound => state.addedProducts.length > 1
      ? ((state.addedProducts.map((e) => e.product.price * e.quantity).toList(growable: false))
          .reduce((a, b) => a + b)).toStringAsFixed(2)
      : '0.0';

  /// Возвращает общую стоимость товаров в корзине без округления.
  double get cartTotalPriceRaw => state.addedProducts.isNotEmpty
      ? (state.addedProducts.map((e) => e.product.price * e.quantity).toList(growable: false))
          .reduce((a, b) => a + b)
      : 0.0;

  /// Возвращает количество товаров в корзине.
  int get productsCountRaw => state.addedProducts.isNotEmpty
      ? state.addedProducts.map((e) => e.quantity).toList(growable: false).reduce((a, b) => a + b)
      : 0;

  @override
  void init() {
    super.init();
    _refreshCart();
  }

  /// Обновляет состояние корзины.
  void _refreshCart() => emit(
        state.newState(
          addedProducts: _selectedProductsSharedCubit.productsInCart,
        ),
      );

  /// Увеличивает количество товара в корзине.
  ///
  /// Принимает [item] - позицию товара в корзине.
  void increaseItemCount(CartPosition item) {
    safeAction(
      action: () async {
        _selectedProductsSharedCubit.incrementItemCount(item);
      },
      isOfflineSupported: true,
    );

    _refreshCart();
  }

  /// Уменьшает количество товара в корзине.
  ///
  /// Принимает [item] - позицию товара в корзине.
  void decreaseItemCount(CartPosition item) {
    safeAction(
      action: () async {
        _selectedProductsSharedCubit.decrementItemCount(item);
      },
      isOfflineSupported: true,
    );

    _refreshCart();
  }

  /// Удаляет товар из корзины.
  ///
  /// Принимает [item] - позицию товара в корзине.
  void deleteItem(CartPosition item) {
    safeAction(
      action: () async {
        _selectedProductsSharedCubit.deleteProduct(item);
      },
      isOfflineSupported: true,
    );

    _refreshCart();
  }

  /// Очищает корзину.
  void deleteCart() {
    safeAction(
      action: () async {
        _selectedProductsSharedCubit.deleteAllProducts();
      },
      isOfflineSupported: true,
    );

    _refreshCart();
  }
}
