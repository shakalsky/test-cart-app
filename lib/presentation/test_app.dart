import 'package:test_products_and_cart/dependency_injector.dart';
import 'package:test_products_and_cart/presentation/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

class CartApp extends StatelessWidget {
  const CartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      navigatorKey: i.get<GlobalKey<NavigatorState>>(),
    );
  }
}
