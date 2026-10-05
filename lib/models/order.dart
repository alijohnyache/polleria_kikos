class OrderItem {
  final String productId;
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromMap(Map<String, dynamic> data) {
    return OrderItem(
      productId: data['productId'] ?? '',
      name: data['name'] ?? '',
      quantity: data['quantity'] ?? 1,
      price: (data['price'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}

class AppOrder {
  final String id;
  final String userId;
  final DateTime date;
  final String status;
  final double total;
  final List<OrderItem> items;

  AppOrder({
    required this.id,
    required this.userId,
    required this.date,
    required this.status,
    required this.total,
    required this.items,
  });

  factory AppOrder.fromMap(Map<String, dynamic> data, String documentId) {
    var itemsData = data['items'] as List<dynamic>? ?? [];
    List<OrderItem> items = itemsData
        .map((item) => OrderItem.fromMap(item as Map<String, dynamic>))
        .toList();

    return AppOrder(
      id: documentId,
      userId: data['userId'] ?? '',
      date: data['date'] != null ? data['date'].toDate() : DateTime.now(),
      status: data['status'] ?? 'pending',
      total: (data['total'] ?? 0.0).toDouble(),
      items: items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': date,
      'status': status,
      'total': total,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }
}
