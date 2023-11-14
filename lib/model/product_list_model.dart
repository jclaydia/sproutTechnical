class Product {
  final int? id;
  final String? title;
  final double? price;
  final String? thumbnail;
  final int? stock;
  final double? discountPercentage;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.stock,
    required this.discountPercentage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      thumbnail: json['thumbnail'],
      stock: json['stock'],
      discountPercentage: json['discountPercentage'].toDouble(),
    );
  }
}
