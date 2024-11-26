import 'package:test_products_and_cart/presentation/widgets/z_import_index.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final double buttonSize;
  final double iconSize;
  final double borderRound;
  final Color backgroundColor;
  final Color iconColor;
  final Function onTap;
  final bool isActive;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.buttonSize,
    required this.iconSize,
    required this.borderRound,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? () => onTap() : null,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRound),
        ),
        width: buttonSize,
        height: buttonSize,
        child: Icon(
          icon,
          color: isActive ? iconColor : Colors.grey,
          size: iconSize,
        ),
      ),
    );
  }
}
