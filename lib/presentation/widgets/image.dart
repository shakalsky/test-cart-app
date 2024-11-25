import 'package:test_products_and_cart/presentation/widgets/import_index.dart';

class AppImage extends StatelessWidget {
  final String? url;
  final double borderRound;
  final bool isFullRounded;

  const AppImage({
    super.key,
    required this.url,
    required this.borderRound,
    required this.isFullRounded,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: isFullRounded
          ? BorderRadius.all(
              Radius.circular(borderRound),
            )
          : BorderRadius.only(
              bottomLeft: Radius.circular(borderRound),
              topLeft: Radius.circular(borderRound),
            ),
      child: CachedNetworkImage(
        imageUrl: url ?? AppStrings.errorImageLink,
        errorWidget: (_, __, error) => const Icon(Icons.error),
        placeholder: (_, __) => SizedBox(
          height: 50.0,
          width: 50.0,
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ),
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
