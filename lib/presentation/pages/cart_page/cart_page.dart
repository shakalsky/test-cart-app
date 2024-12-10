import 'package:test_products_and_cart/presentation/pages/cart_page/cart_page_cubit.dart';
import 'package:test_products_and_cart/presentation/pages/page_import_index.dart';

class CartPage extends BasePage {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends BasePageState<CartPage, CartPageCubit> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // First get the FlutterView.
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
// TODO: remove from here
// Dimensions in logical pixels (dp)
    Size size = view.physicalSize / view.devicePixelRatio;

    return BlocBuilder<CartPageCubit, CartPageState>(
      bloc: cubit,
      builder: (_, state) => Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.primaryBackground,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 32.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppIconButton(
                          onTap: () => Navigator.of(context).pop(),
                          borderRound: 10,
                          buttonSize: 42,
                          backgroundColor: AppColors.iconBackgroundPrimary,
                          icon: Icons.arrow_back_rounded,
                          iconColor: AppColors.primaryHighlight,
                          iconSize: 25,
                        ),
                        Expanded(
                          child: Text(
                            'Корзина',
                            textAlign: TextAlign.center,
                            style: AppTypography.headline,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              cubit.productsCountRaw.toString(),
                              textAlign: TextAlign.center,
                              style: AppTypography.headline,
                            ),
                            Text(
                              ' шт.',
                              textAlign: TextAlign.center,
                              style: AppTypography.bodyDefault,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.addedProducts.length,
                      itemBuilder: (_, index) => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 100.0,
                                width: 100.0,
                                child: AppImage(
                                  url: state.addedProducts[index].product.photoUrls?.first ??
                                      AppStrings.errorImageLink,
                                  borderRound: 10,
                                  isFullRounded: true,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width / 3,
                                    child: Text(
                                      state.addedProducts[index].product.name,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Price(state.addedProducts[index].product.price),
                                ],
                              ),
                              Spacer(),
                              QuantityManipulator(
                                onIncrease: () => cubit.increaseItemCount(
                                  state.addedProducts[index],
                                ),
                                onDecrease: () => cubit.decreaseItemCount(
                                  state.addedProducts[index],
                                ),
                                isOnDecreaseActive: state.addedProducts[index].quantity > 1,
                                onDelete: () => cubit.deleteItem(state.addedProducts[index]),
                                itemsQuantity: state.addedProducts[index].quantity,
                              ),
                            ],
                          ),
                          if (state.addedProducts.length != index + 1) const Divider(thickness: 1),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: AppColors.primary,
                    indent: 20.0,
                    endIndent: 20.0,
                  ),
                  const SizedBox(height: 12.0),
                  Price(name: 'СУММА:', cubit.cartTotalPriceRaw),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'СТОИМОСТЬ ДОСТАВКИ:',
                        style: AppTypography.bodyDefault.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'БЕСПЛАТНО',
                        style: AppTypography.bodyDefault,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Price(name: 'ВСЕГО:', cubit.cartTotalPriceRaw),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      AppIconButton(
                        onTap: () => DialogsUtil.showDialogApprove(
                            context: context,
                            title: 'Внимание',
                            content: 'Вы уверены, что хотите удалить все товары в корзине?',
                            submitText: 'Да, удалить',
                            onSubmitTap: cubit.deleteCart,
                            cancelText: 'Оставить'),
                        borderRound: 10,
                        buttonSize: 48,
                        backgroundColor: AppColors.primary,
                        icon: Icons.delete_sweep_rounded,
                        iconColor: AppColors.primaryHighlight,
                        iconSize: 25,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: AppTextButton(
                          onTap: () {},
                          name: 'Оформить заказ',
                          height: 48,
                          borderRound: 10,
                          backgroundColor: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
