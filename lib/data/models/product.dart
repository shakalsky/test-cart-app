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

  Map<String, String> toMapObject(int count) => {
        'id': id.toString(),
        'name': name,
        'price': price.toString(),
        'count': count.toString(),
        if (photoUrls != null) 'photo_urls': photoUrls!.join(','),
        if (description != null) 'description': description!,
      };

  static (Product, int) fromMapObject(Map<dynamic, dynamic> object) {
    return (
      Product(
        id: int.parse(object['id']),
        name: object['name']!,
        price: double.parse(object['price']),
        description: object['description'],
        photoUrls: object['photo_urls']?.split(','),
      ),
      int.parse(object['count']),
    );
  }

  @override
  operator ==(other) => other is Product && other.id == id;

  @override
  int get hashCode => Object.hash(id, name, price);
}
