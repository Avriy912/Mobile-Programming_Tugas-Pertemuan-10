class ProductItem {
  final String id;
  final String name;
  final String category;
  final double price;
  final int stock;
  final int sold;
  final String trend;

  ProductItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.sold,
    required this.trend,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
      sold: json['sold'],
      trend: json['trend'],
    );
  }
}