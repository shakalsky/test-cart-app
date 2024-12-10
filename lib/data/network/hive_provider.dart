import 'package:hive_flutter/adapters.dart';

/// Провайдер для работы с Hive.
///
/// Этот класс реализует методы для инициализации, сохранения, удаления и получения данных из локального хранилища Hive.
class HiveProvider {
  /// Инициализирует Hive и открывает коробку 'products_box'.
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('products_box');
  }

  /// Сохраняет данные в коробку Hive.
  ///
  /// Принимает [key] - ключ для сохранения данных и [value] - значение в формате Map.
  void saveToBox(String key, Map<String, String> value) {
    Hive.box('products_box').put(key, value);
  }

  /// Удаляет все данные из коробки Hive.
  void deleteAll() {
    Hive.box('products_box').clear();
  }

  /// Получает все значения из коробки Hive.
  ///
  /// Возвращает список со всеми значениями, если коробка открыта, иначе - пустой список.
  Iterable<dynamic> getAllValues() {
    return Hive.box('products_box').isOpen ? Hive.box('products_box').values : [];
  }
}
