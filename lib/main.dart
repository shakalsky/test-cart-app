import 'package:flutter/material.dart';
import 'package:test_products_and_cart/dependency_injector.dart';
import 'package:test_products_and_cart/presentation/test_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initInjector();
  runApp(
    const CartApp(),
  );
}
