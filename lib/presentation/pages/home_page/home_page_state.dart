part of 'home_page_cubit.dart';

class HomePageState {
  List<Product> products;

  HomePageState({
    required this.products,
  });

  HomePageState newState({
    List<Product>? products,
  }) {
    return HomePageState(
      products: products ?? this.products,
    );
  }

  List<Object?> get props => [
        products,
      ];
}
