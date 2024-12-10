import 'package:test_products_and_cart/presentation/shared/shared_cart_cubit.dart';
import 'package:test_products_and_cart/presentation/models/cart_position.dart';
import 'package:test_products_and_cart/presentation/state_manager/base_cubit.dart';

part 'cart_page_state.dart';

class CartPageCubit extends BaseCubit<CartPageState> {
  final SelectedProductsSharedCubit _selectedProductsSharedCubit;

  CartPageCubit({required SelectedProductsSharedCubit selectedProductsSharedCubit})
      : _selectedProductsSharedCubit = selectedProductsSharedCubit,
        super(
          CartPageState(
            addedProducts: [],
          ),
        );

  String get cartTotalPriceRound => state.addedProducts.length > 1
      ? ((state.addedProducts.map((e) => e.product.price * e.quantity).toList(growable: false))
          .reduce((a, b) => a + b)).toStringAsFixed(2)
      : '0.0';

  double get cartTotalPriceRaw => state.addedProducts.isNotEmpty
      ? (state.addedProducts.map((e) => e.product.price * e.quantity).toList(growable: false))
          .reduce((a, b) => a + b)
      : 0.0;

  int get productsCountRaw => state.addedProducts.isNotEmpty
      ? state.addedProducts.map((e) => e.quantity).toList(growable: false).reduce((a, b) => a + b)
      : 0;

  @override
  void init() {
    super.init();
    _refreshCart();
  }

  void _refreshCart() => emit(
        state.newState(
          addedProducts: _selectedProductsSharedCubit.productsInCart,
        ),
      );

  void increaseItemCount(CartPosition item) {
    safeAction(
      action: () async {
        _selectedProductsSharedCubit.incrementItemCount(item);
      },
      isOfflineSupported: true,
    );

    _refreshCart();
  }

  void decreaseItemCount(CartPosition item) {
    safeAction(
      action: () async {
        _selectedProductsSharedCubit.decrementItemCount(item);
      },
      isOfflineSupported: true,
    );

    _refreshCart();
  }

  void deleteItem(CartPosition item) {
    safeAction(
      action: () async {
        _selectedProductsSharedCubit.deleteProduct(item);
      },
      isOfflineSupported: true,
    );

    _refreshCart();
  }

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
