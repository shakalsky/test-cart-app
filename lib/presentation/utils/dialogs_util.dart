import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:test_products_and_cart/dependency_injector.dart';
import 'package:test_products_and_cart/presentation/pages/cart_page/cart_page.dart';
import 'package:test_products_and_cart/presentation/widgets/z_import_index.dart';

abstract class DialogsUtil {
  static Future<void> showDialogInfo({
    required BuildContext context,
    required String title,
    required String content,
    required String submitText,
    required VoidCallback onTap,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        if (Platform.isAndroid) {
          return AlertDialog(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: onTap,
                child: Text(submitText),
              ),
            ],
          );
        } else {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: AppTypography.bodyDefault.copyWith(color: Colors.black),
            ),
            content: Text(
              content,
              style: AppTypography.bodyDefault.copyWith(color: Colors.black),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: onTap,
                child: Text(
                  submitText,
                  style: AppTypography.bodyDefault.copyWith(color: Colors.black),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  static Future<void> showDialogApprove({
    required BuildContext context,
    required String title,
    required String content,
    required String submitText,
    required VoidCallback onSubmitTap,
    required String cancelText,
    VoidCallback? onCancelTap,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        if (Platform.isAndroid) {
          return AlertDialog(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => onCancelTap == null
                    ? Navigator.of(context).canPop()
                        ? Navigator.of(context).pop()
                        : null
                    : onCancelTap(),
                child: Text(cancelText),
              ),
              TextButton(
                onPressed: onSubmitTap,
                child: Text(submitText),
              ),
            ],
          );
        } else {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                onPressed: () => onCancelTap == null
                    ? Navigator.of(context).canPop()
                        ? Navigator.of(context).pop()
                        : null
                    : onCancelTap(),
                child: Text(cancelText),
              ),
              CupertinoDialogAction(
                onPressed: onSubmitTap,
                child: Text(submitText),
              ),
            ],
          );
        }
      },
    );
  }

  static Future<void> showDialogError({
    required String title,
    required String content,
  }) async {
    showDialog(
      context: i.get<GlobalKey<NavigatorState>>().currentContext!,
      barrierDismissible: false,
      builder: (context) {
        if (Platform.isAndroid) {
          return AlertDialog(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.feedback,
                  size: 50,
                  color: Colors.black,
                ),
                const SizedBox(height: 12.0),
                Text(content),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Закрыть'),
              ),
            ],
          );
        } else {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: AppTypography.headline.copyWith(color: Colors.black),
            ),
            content: Text(
              content,
              style: AppTypography.bodyDefault.copyWith(color: Colors.black),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Закрыть',
                  style: AppTypography.bodyDefault.copyWith(color: Colors.black),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  static Future<void> showDialogProductsCount({
    required BuildContext context,
    required String productName,
    required void Function(int) addProductsToCart,
  }) async {
    int itemsCount = 1;
    Widget cancelButton = TextButton(
      child: const Text('Закрыть'),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget continueButton = TextButton(
      child: const Text('Добавить'),
      onPressed: () {
        addProductsToCart(itemsCount);
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartPage(),
          ),
        );
      },
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, refresh) {
            return AlertDialog(
              title: Text(productName),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Заказать $itemsCount продукт(ов)',
                    style: AppTypography.bodyDefault,
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIconButton(
                        onTap: () {
                          if (itemsCount > 1) {
                            itemsCount--;
                            refresh(() {});
                          }
                        },
                        borderRound: 10,
                        buttonSize: 42,
                        backgroundColor: const Color(0xFF343235),
                        icon: Icons.remove,
                        iconColor: Colors.white,
                        iconSize: 25,
                      ),
                      const SizedBox(width: 16.0),
                      AppIconButton(
                        onTap: () {
                          itemsCount++;
                          refresh(() {});
                        },
                        borderRound: 10,
                        buttonSize: 42,
                        backgroundColor: const Color(0xFF343235),
                        icon: Icons.add,
                        iconColor: Colors.white,
                        iconSize: 25,
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                cancelButton,
                continueButton,
              ],
            );
          },
        );
      },
    );
  }
}
