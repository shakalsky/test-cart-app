import 'package:hive_flutter/adapters.dart';

class HiveProvider {
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('products_box');
  }

  void saveToBox(String key, Map<String, String> value) {
    Hive.box('products_box').put(key, value);
  }

  void deleteAll() {
    Hive.box('products_box').clear();
  }

  Iterable<dynamic> getAllValues() {
    return Hive.box('products_box').isOpen ? Hive.box('products_box').values : [];
  }
}
