import 'package:test_products_and_cart/data/models/product.dart';
import 'package:test_products_and_cart/presentation/models/cart_position.dart';
import 'package:test_products_and_cart/presentation/shared/shared_cart_cubit.dart';
import 'package:test_products_and_cart/presentation/state_manager/base_cubit.dart';

part 'item_page_state.dart';

/// Кубит для страницы товара.
///
/// Этот класс реализует методы для управления состоянием страницы товара, включая
/// инициализацию товара и добавление товаров в корзину.
class ItemPageCubit extends BaseCubit<ItemPageState> {
  final SelectedProductsSharedCubit _selectedProductsSharedCubit;

  /// Конструктор класса [ItemPageCubit].
  ///
  /// Принимает [selectedProductsSharedCubit] для управления выбранными продуктами.
  ItemPageCubit({required SelectedProductsSharedCubit selectedProductsSharedCubit})
      : _selectedProductsSharedCubit = selectedProductsSharedCubit,
        super(
          ItemPageState(
            product: Product.mock(),
            productsCount: 1,
          ),
        );

  /// Инициализирует товар.
  ///
  /// Принимает [product] и обновляет состояние с новым товаром.
  void initProduct(Product product) {
    emit(
      state.newState(product: product),
    );
  }

  /// Добавляет товары в корзину.
  ///
  /// Принимает [productsCount] - количество добавляемых товаров.
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
