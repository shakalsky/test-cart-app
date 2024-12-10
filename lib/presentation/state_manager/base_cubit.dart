import 'dart:async';

import 'package:dio/dio.dart';
import 'package:test_products_and_cart/dependency_injector.dart';
import 'package:test_products_and_cart/presentation/utils/connectivity_client.dart';
import 'package:test_products_and_cart/presentation/utils/dialogs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'base_page.dart';

/// Базовый кубит.
///
/// Этот класс предоставляет базовые методы для работы с состоянием и безопасным выполнением действий.
class BaseCubit<St> extends Cubit<St> {
  BaseCubit(super.st);

  ConnectivityClient connectivityClient = i.get<ConnectivityClient>();

  /// Выполняет безопасное действие с учетом подключения к интернету.
  ///
  /// Принимает [action] - действие для выполнения.
  /// Параметр [isOfflineSupported] указывает, поддерживается ли выполнение действия в оффлайн-режиме.
  /// [errorAction] - действие при возникновении ошибки (необязательный параметр).
  @protected
  Future<void> safeAction({
    required Function action,
    bool isOfflineSupported = false,
    Function(Object err, StackTrace stt)? errorAction,
  }) async {
    if (!isOfflineSupported && !connectivityClient.hasInternetConnection) {
      await connectivityClient.checkConnection();
      if (!connectivityClient.hasInternetConnection) {
        DialogsUtil.showDialogError(
          title: 'Ошибка',
          content: 'Соединие с интернетом потеряно',
        );
        return;
      }
    }
    try {
      await action();
    } catch (e, stt) {
      debugPrint(e.toString() + stt.toString());
      if (errorAction == null) {
        if (e is DioException) {
          DialogsUtil.showDialogError(
            title: 'Ошибка загрузчика на устройстве',
            content: e.message.toString(),
          );
          return;
        }
        DialogsUtil.showDialogError(
          title: 'Ошибка загрузки',
          content: e.toString(),
        );
      } else {
        errorAction(e, stt);
      }
    }
  }

  /// Инициализирует кубит.
  void init() {
    debugPrint('Init cubit $runtimeType');
  }

  /// Освобождает ресурсы кубита.
  void dispose() async {
    debugPrint('Dispose cubit $runtimeType');
  }
}
