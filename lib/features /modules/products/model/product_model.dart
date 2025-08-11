class ProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final String location;
  final String description;
  final String date;
  final String sellerName;
  final String sellerLocation;
  final bool selected;

  ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.location,
    required this.description,
    required this.date,
    required this.sellerName,
    required this.sellerLocation,
    this.selected = false,
  });

  factory ProductModel.fromFirestore(Map<String, dynamic> json, String id) {
    return ProductModel(
      id: id,
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: json['price'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      sellerName: json['seller']['name'] ?? '',
      sellerLocation: json['seller']['location'] ?? '',
    );
  }
}
