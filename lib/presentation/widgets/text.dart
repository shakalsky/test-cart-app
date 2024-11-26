import 'package:test_products_and_cart/presentation/widgets/z_import_index.dart';

class AppText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;

  const AppText({
    super.key,
    required this.text,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.manrope().copyWith(
        color: AppColors.primaryHighlight,
        fontWeight: fontWeight,
      ),
    );
  }
}
