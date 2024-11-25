import 'package:test_products_and_cart/presentation/pages/home_page/home_page_cubit.dart';
import 'package:test_products_and_cart/presentation/pages/page_import_index.dart';

class HomePage extends BasePage {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage, HomePageCubit> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double appBarIconSize = 42.0;
    return BlocBuilder<HomePageCubit, HomePageState>(
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(start: appBarIconSize),
                          child: Text(
                            'Каталог товаров',
                            textAlign: TextAlign.center,
                            style: AppTypography.headline,
                          ),
                        ),
                      ),
                      AppIconButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CartPage(),
                            ),
                          );
                        },
                        borderRound: 10,
                        buttonSize: appBarIconSize,
                        backgroundColor: AppColors.iconBackgroundPrimary,
                        iconSize: 25,
                        iconColor: Colors.white,
                        icon: Icons.shopping_cart_outlined,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  state.products.isEmpty
                      ? AppTextButton(
                          name: 'Загрузить',
                          height: 40,
                          borderRound: 10,
                          backgroundColor: AppColors.primary,
                          onTap: cubit.getProducts,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      : Expanded(
                          child: GridView.builder(
                            itemCount: state.products.length,
                            padding: const EdgeInsets.only(top: 8.0),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.64,
                            ),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => AppTile(
                              product: state.products[index],
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemDetailsPage(
                                    product: state.products[index],
                                  ),
                                ),
                              ),
                            ),
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
