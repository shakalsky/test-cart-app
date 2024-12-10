import 'package:test_products_and_cart/data/models/product.dart';
import 'package:test_products_and_cart/data/products_repository.dart';
import 'package:test_products_and_cart/presentation/shared/shared_cart_cubit.dart';
import 'package:test_products_and_cart/presentation/state_manager/base_cubit.dart';

part 'home_page_state.dart';

/// Кубит для главной страницы.
///
/// Этот класс реализует методы для управления состоянием главной страницы, включая
/// получение списка продуктов и обновление состояния с новыми данными.
class HomePageCubit extends BaseCubit<HomePageState> {
  final SelectedProductsSharedCubit _selectedProductsSharedCubit;
  final ProductRepositoryImpl _repository;

  /// Конструктор класса [HomePageCubit].
  ///
  /// Принимает [productRepositoryImpl] для взаимодействия с репозиторием продуктов и [selectedProductsSharedCubit] для управления корзиной продуктов.
  HomePageCubit({
    required ProductRepositoryImpl productRepositoryImpl,
    required SelectedProductsSharedCubit selectedProductsSharedCubit,
  })  : _repository = productRepositoryImpl,
        _selectedProductsSharedCubit = selectedProductsSharedCubit,
        super(
          HomePageState(
            products: [],
          ),
        );

  @override
  void init() {
    super.init();
    _selectedProductsSharedCubit.getSavedProducts();
  }

  /// Получает список продуктов и обновляет состояние.
  void getProducts() async {
    safeAction(action: () async {
      final newProducts = await _repository.fetchProductsList();

      emit(
        state.newState(products: newProducts),
      );
    });
  }
}
