class Product {
  int id;
  String name;
  String? description;
  double price;
  List<String?>? photoUrls;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.photoUrls,
  });

  factory Product.mock() => Product(
        id: 0,
        name: 'name',
        price: 0,
        description: 'mock product',
      );

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['title'],
      price: json['price'],
      description: json['description'],
      photoUrls: (json['images'] as List).cast<String>(),
    );
  }
}
