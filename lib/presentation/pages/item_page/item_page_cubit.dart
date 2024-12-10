import 'package:test_products_and_cart/data/models/product.dart';
import 'package:test_products_and_cart/presentation/models/cart_position.dart';
import 'package:test_products_and_cart/presentation/shared/shared_cart_cubit.dart';
import 'package:test_products_and_cart/presentation/state_manager/base_cubit.dart';

part 'item_page_state.dart';

class ItemPageCubit extends BaseCubit<ItemPageState> {
  final SelectedProductsSharedCubit _selectedProductsSharedCubit;

  ItemPageCubit({required SelectedProductsSharedCubit selectedProductsSharedCubit})
      : _selectedProductsSharedCubit = selectedProductsSharedCubit,
        super(
          ItemPageState(
            product: Product.mock(),
            productsCount: 1,
          ),
        );

  void initProduct(Product product) {
    emit(
      state.newState(product: product),
    );
  }

  void addProductsToCart(int productsCount) {
    safeAction(
      action: () async {
        _selectedProductsSharedCubit.addProduct(
          CartPosition(state.product, productsCount),
        );
      },
      isOfflineSupported: true,
    );
  }
}
