import 'package:test_products_and_cart/data/models/product.dart';
import 'package:test_products_and_cart/data/products_repository.dart';
import 'package:test_products_and_cart/presentation/state_manager/base_cubit.dart';

part 'home_page_state.dart';

class HomePageCubit extends BaseCubit<HomePageState> {
  final ProductRepositoryImpl _repository;

  HomePageCubit({
    required ProductRepositoryImpl productRepositoryImpl,
  })  : _repository = productRepositoryImpl,
        super(
          HomePageState(
            products: [],
          ),
        );

  void getProducts() async {
    final newProducts = await _repository.fetchProductsList();

    emit(
      state.newState(products: newProducts),
    );
  }
}
