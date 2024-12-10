import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Клиент для проверки подключения к интернету.
///
/// Этот класс реализует методы для инициализации подписки на изменения подключения и проверки текущего состояния подключения.
class ConnectivityClient {
  late StreamSubscription<List<ConnectivityResult>> subscription;
  bool hasInternetConnection = true;

  /// Конструктор класса [ConnectivityClient].
  ConnectivityClient() {
    init();
  }

  /// Инициализирует подписку на изменения состояния подключения.
  void init() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        hasInternetConnection =
            (result.first == ConnectivityResult.mobile || result.first == ConnectivityResult.wifi);
      },
    );
  }

  /// Проверяет текущее состояние подключения.
  ///
  /// Обновляет значение [hasInternetConnection] в зависимости от результата.
  Future<void> checkConnection() async {
    final ConnectivityResult result = (await Connectivity().checkConnectivity()).first;
    hasInternetConnection =
        (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi);
  }
}
