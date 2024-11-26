import 'package:test_products_and_cart/presentation/widgets/z_import_index.dart';

class QuantityManipulator extends StatelessWidget {
  final Function onIncrease;
  final bool isOnIncreaseActive;
  final Function onDecrease;
  final bool isOnDecreaseActive;
  final Function onDelete;
  final int itemsQuantity;

  const QuantityManipulator({
    super.key,
    required this.onIncrease,
    this.isOnIncreaseActive = true,
    required this.onDecrease,
    this.isOnDecreaseActive = true,
    required this.onDelete,
    required this.itemsQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIconButton(
                onTap: onDecrease,
                isActive: isOnDecreaseActive,
                borderRound: 30,
                buttonSize: 30,
                icon: Icons.arrow_left_rounded,
                backgroundColor: Colors.transparent,
                iconSize: 30,
                iconColor: AppColors.iconPrimary,
              ),
              Expanded(
                child: Text(
                  itemsQuantity.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
              AppIconButton(
                onTap: onIncrease,
                borderRound: 30,
                buttonSize: 30,
                icon: Icons.arrow_right_rounded,
                backgroundColor: Colors.transparent,
                iconSize: 30,
                iconColor: AppColors.iconPrimary,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        AppIconButton(
          onTap: onDelete,
          borderRound: 30,
          buttonSize: 30,
          icon: Icons.delete,
          backgroundColor: Colors.transparent,
          iconSize: 30,
          iconColor: AppColors.iconPrimary,
        ),
      ],
    );
  }
}
