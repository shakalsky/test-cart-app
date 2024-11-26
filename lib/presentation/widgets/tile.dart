import 'package:test_products_and_cart/presentation/widgets/z_import_index.dart';

class AppTile extends StatelessWidget {
  final Product product;
  final Function? onTap;

  const AppTile({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryHighlight,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: AppImage(
                url: product.photoUrls?.first ?? AppStrings.errorImageLink,
                borderRound: 0,
                isFullRounded: true,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 8.0,
                start: 2.0,
                end: 2.0,
              ),
              child: Text(
                product.name,
                style: AppTypography.tileHeadline,
              ),
            ),
            SizedBox(height: 4.0),
            AppTextButton(
              onTap: onTap ?? () => {},
              name: 'Подробнее',
              height: 24,
              backgroundColor: AppColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              borderRound: 4,
            ),
          ],
        ),
      ),
    );
  }
}
