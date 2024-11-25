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
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0),
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
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 42, 0),
                            child: Text(
                              'Корзина',
                              textAlign: TextAlign.center,
                              style: AppTypography.headline,
                            ),
                          ),
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
                                  url: state.addedProducts[index].photoUrls?.first ??
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
                                      state.addedProducts[index].name,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$',
                                        style: AppTypography.headline,
                                      ),
                                      Text(
                                        '${state.addedProducts[index].price}.',
                                        style: AppTypography.headline,
                                      ),
                                      Text(
                                        '99',
                                        style: AppTypography.bodyDefault,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      AppIconButton(
                                        onTap: () =>
                                            cubit.decreaseItemCount(state.addedProducts[index]),
                                        borderRound: 30,
                                        buttonSize: 30,
                                        icon: Icons.arrow_left_rounded,
                                        backgroundColor: Colors.transparent,
                                        iconSize: 30,
                                        iconColor: AppColors.iconPrimary,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text('1'),
                                      ),
                                      AppIconButton(
                                        onTap: () =>
                                            cubit.increaseItemCount(state.addedProducts[index]),
                                        borderRound: 30,
                                        buttonSize: 30,
                                        icon: Icons.arrow_right_rounded,
                                        backgroundColor: Colors.transparent,
                                        iconSize: 30,
                                        iconColor: AppColors.iconPrimary,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  AppIconButton(
                                    onTap: () => cubit.deleteItem(state.addedProducts[index]),
                                    borderRound: 30,
                                    buttonSize: 30,
                                    icon: Icons.delete,
                                    backgroundColor: Colors.transparent,
                                    iconSize: 30,
                                    iconColor: AppColors.iconPrimary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'СУММА',
                          style: AppTypography.bodyDefault.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$',
                              style: AppTypography.headline,
                            ),
                            Text(
                              '${cubit.cartTotalPrice}.',
                              style: AppTypography.headline,
                            ),
                            Text(
                              '99',
                              style: AppTypography.bodyDefault,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                    child: Row(
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
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ВСЕГО:',
                          style: AppTypography.bodyDefault.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$',
                              style: AppTypography.headline,
                            ),
                            Text(
                              '${cubit.cartTotalPrice}.',
                              style: AppTypography.headline,
                            ),
                            Text(
                              '99',
                              style: AppTypography.bodyDefault,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                    child: AppTextButton(
                      onTap: () {},
                      name: 'Оформить заказ',
                      height: 48,
                      borderRound: 15,
                      backgroundColor: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
