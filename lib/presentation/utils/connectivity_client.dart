import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityClient {
  late StreamSubscription<List<ConnectivityResult>> subscription;
  bool hasInternetConnection = true;

  ConnectivityClient() {
    init();
  }

  void init() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        hasInternetConnection =
            (result.first == ConnectivityResult.mobile || result.first == ConnectivityResult.wifi);
      },
    );
  }

  Future<void> checkConnection() async {
    final ConnectivityResult result = (await Connectivity().checkConnectivity()).first;
    hasInternetConnection =
        (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi);
  }
}
