import 'package:test_products_and_cart/presentation/widgets/import_index.dart';

class AppTextButton extends StatelessWidget {
  final String name;
  final double height;
  final double borderRound;
  final Color backgroundColor;
  final Function onTap;
  final double fontSize;
  final FontWeight fontWeight;

  final double? width;

  const AppTextButton({
    super.key,
    required this.name,
    required this.height,
    required this.borderRound,
    required this.backgroundColor,
    required this.onTap,
    required this.fontSize,
    required this.fontWeight,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: width ?? double.infinity,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRound),
        ),
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope().copyWith(
            color: Colors.white,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
