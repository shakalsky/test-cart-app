import 'package:test_products_and_cart/data/models/product.dart';
import 'package:test_products_and_cart/data/shared/shared_cart_cubit.dart';
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

  String get cartTotalPrice => state.addedProducts.length > 1
      ? ((state.addedProducts.map((e) => e.price).toList(growable: false)).reduce((a, b) => a + b))
          .toStringAsFixed(2)
      : '0.0';

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

  void increaseItemCount(Product item) {
    _selectedProductsSharedCubit.incrementItemCount(item);
    _refreshCart();
  }

  void decreaseItemCount(Product item) {
    if (state.addedProducts.where((e) => e.name == item.name).length > 1) {
      _selectedProductsSharedCubit.decrementItemCount(item);
    }
    _refreshCart();
  }

  void deleteItem(Product item) {
    _selectedProductsSharedCubit.deleteProduct(item);
    _refreshCart();
  }
}
