import 'package:test_products_and_cart/presentation/widgets/z_import_index.dart';

class PicsSlider extends StatefulWidget {
  final List<String?>? photoUrls;

  const PicsSlider(this.photoUrls, {super.key});

  @override
  State<PicsSlider> createState() => _PicsSliderState();
}

class _PicsSliderState extends State<PicsSlider> {
  String? selectedPhotoUrl;

  @override
  void initState() {
    selectedPhotoUrl = widget.photoUrls?.first;

    super.initState();
  }

  void selectMainPhoto(String? url) {
    setState(() {
      selectedPhotoUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: const BoxDecoration(
        color: Color(0xFFD9E9E0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 16.0, 20.0),
              child: ListView.builder(
                itemCount: widget.photoUrls?.length ?? 0,
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () => selectMainPhoto(
                    widget.photoUrls![index],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: selectedPhotoUrl == widget.photoUrls![index]
                          ? BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            )
                          : null,
                      width: 50.0,
                      height: 50.0,
                      child: AppImage(
                        url: widget.photoUrls![index],
                        isFullRounded: true,
                        borderRound: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                color: AppColors.primaryBackground,
              ),
              child: AppImage(
                url: selectedPhotoUrl,
                borderRound: 20,
                isFullRounded: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
