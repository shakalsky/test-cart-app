import 'package:test_products_and_cart/presentation/widgets/z_import_index.dart';

extension NumExtensions on num {
  bool get isInt => (this % 1) == 0;

  int get doubleDecimalUpToHundreds => ((this - (this).truncate()) * 100).truncate();
}

class Price extends StatelessWidget {
  final String name;
  final double price;

  const Price(
    this.price, {
    super.key,
    this.name = '',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
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
              '${price.toInt()}.',
              style: AppTypography.headline,
            ),
            Text(
              price.doubleDecimalUpToHundreds.toString(),
              style: AppTypography.bodyDefault,
            ),
          ],
        ),
      ],
    );
  }
}
