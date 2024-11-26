import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_products_and_cart/data/network/api_provider.dart';
import 'package:test_products_and_cart/data/products_repository.dart';
import 'package:test_products_and_cart/presentation/shared/shared_cart_cubit.dart';
import 'package:test_products_and_cart/presentation/pages/cart_page/cart_page_cubit.dart';
import 'package:test_products_and_cart/presentation/pages/home_page/home_page_cubit.dart';
import 'package:test_products_and_cart/presentation/pages/item_page/item_page_cubit.dart';
import 'package:test_products_and_cart/presentation/utils/connectivity_client.dart';
import 'package:get_it/get_it.dart';

GetIt get i => GetIt.instance;

final Dio _dio = Dio();
final ApiProvider _apiProvider = ApiProvider(dio: _dio);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void initInjector() {
  i.registerSingleton<ProductRepositoryImpl>(
    ProductRepositoryImpl(apiProvider: _apiProvider),
  );

  i.registerSingleton<SelectedProductsSharedCubit>(
    SelectedProductsSharedCubit(),
  );

  i.registerSingleton<ConnectivityClient>(
    ConnectivityClient(),
  );

  i.registerSingleton<GlobalKey<NavigatorState>>(
    navigatorKey,
  );

  i.registerFactory<HomePageCubit>(
    () => HomePageCubit(
      productRepositoryImpl: i.get(),
    ),
  );

  i.registerFactory<CartPageCubit>(
    () => CartPageCubit(
      selectedProductsSharedCubit: i.get(),
    ),
  );

  i.registerFactory<ItemPageCubit>(
    () => ItemPageCubit(
      selectedProductsSharedCubit: i.get(),
    ),
  );
}
