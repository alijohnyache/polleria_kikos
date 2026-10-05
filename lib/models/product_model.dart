class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category; // Entradas, Pollos, Comida Criolla, Parrillas
  final String imageUrl;
  final bool isOffer;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl = '',
    this.isOffer = false,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ProductModel(
      id: documentId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      category: data['category'] ?? 'Otros',
      imageUrl: data['imageUrl'] ?? '',
      isOffer: data['isOffer'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'isOffer': isOffer,
    };
  }
}
