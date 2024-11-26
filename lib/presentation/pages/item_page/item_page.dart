import 'package:test_products_and_cart/presentation/pages/item_page/item_page_cubit.dart';
import 'package:test_products_and_cart/presentation/pages/page_import_index.dart';

class ItemDetailsPage extends BasePage {
  final Product product;

  const ItemDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends BasePageState<ItemDetailsPage, ItemPageCubit> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    cubit.initProduct(widget.product);
    super.initState();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemPageCubit, ItemPageState>(
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
                  // page app bar
                  SizedBox(
                    height: 42.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppIconButton(
                          onTap: () => Navigator.pop(context),
                          borderRound: 10,
                          buttonSize: 42,
                          backgroundColor: const Color(0xFF343235),
                          icon: Icons.arrow_back_rounded,
                          iconColor: Colors.white,
                          iconSize: 25,
                        ),
                        Expanded(
                          child: Text(
                            'Инфо',
                            textAlign: TextAlign.center,
                            style: AppTypography.headline,
                          ),
                        ),
                        AppIconButton(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(),
                            ),
                          ),
                          borderRound: 10,
                          buttonSize: 42,
                          backgroundColor: const Color(0xFF343235),
                          icon: Icons.shopping_cart_outlined,
                          iconColor: Colors.white,
                          iconSize: 25,
                        ),
                      ],
                    ),
                  ),
                  // page app bar end region
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: PicsSlider(widget.product.photoUrls),
                  ),
                  // item description
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9E9E0),
                      ),
                      child: Text(
                        widget.product.name,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontFamily: 'Manrope',
                              fontSize: 20,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 16.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 50.0,
                          child: Text(
                            widget.product.description ?? '',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontFamily: 'Manrope',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // item description end region
                  Divider(color: AppColors.primary),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Price(widget.product.price),
                        AppTextButton(
                          onTap: () => DialogsUtil.showDialogProductsCount(
                            context: context,
                            productName: state.product.name,
                            addProductsToCart: (count) => cubit.addProductsToCart(count),
                          ),
                          name: 'Оформить заказ',
                          width: 200,
                          height: 48,
                          backgroundColor: const Color(0xFF427A5B),
                          borderRound: 15,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
