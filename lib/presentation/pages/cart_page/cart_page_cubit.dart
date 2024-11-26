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

  double get cartTotalPriceRaw =>
      (state.addedProducts.map((e) => e.product.price * e.quantity).toList(growable: false))
          .reduce((a, b) => a + b);

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
    _selectedProductsSharedCubit.incrementItemCount(item);
    _refreshCart();
  }

  void decreaseItemCount(CartPosition item) {
    _selectedProductsSharedCubit.decrementItemCount(item);
    _refreshCart();
  }

  void deleteItem(CartPosition item) {
    _selectedProductsSharedCubit.deleteProduct(item);
    _refreshCart();
  }
}
