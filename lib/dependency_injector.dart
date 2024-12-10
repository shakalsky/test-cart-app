import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_products_and_cart/data/network/api_provider.dart';
import 'package:test_products_and_cart/data/network/hive_provider.dart';
import 'package:test_products_and_cart/data/products_repository.dart';
import 'package:test_products_and_cart/presentation/shared/shared_cart_cubit.dart';
import 'package:test_products_and_cart/presentation/pages/cart_page/cart_page_cubit.dart';
import 'package:test_products_and_cart/presentation/pages/home_page/home_page_cubit.dart';
import 'package:test_products_and_cart/presentation/pages/item_page/item_page_cubit.dart';
import 'package:test_products_and_cart/presentation/utils/connectivity_client.dart';
import 'package:get_it/get_it.dart';

GetIt get i => GetIt.instance;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> initInjector() async {
  i.registerSingleton<GlobalKey<NavigatorState>>(
    navigatorKey,
  );

  i.registerSingleton<Dio>(
    Dio(),
  );

  i.registerSingleton<ApiProvider>(
    ApiProvider(dio: i.get()),
  );

  i.registerSingleton<HiveProvider>(
    HiveProvider(),
  );
  await i.get<HiveProvider>().init();

  i.registerSingleton<ProductRepositoryImpl>(
    ProductRepositoryImpl(
      apiProvider: i.get(),
      hiveProvider: i.get(),
    ),
  );

  i.registerSingleton<SelectedProductsSharedCubit>(
    SelectedProductsSharedCubit(
      productRepository: i.get(),
    ),
  );

  i.registerSingleton<ConnectivityClient>(
    ConnectivityClient(),
  );

  i.registerFactory<HomePageCubit>(
    () => HomePageCubit(
      productRepositoryImpl: i.get(),
      selectedProductsSharedCubit: i.get(),
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
