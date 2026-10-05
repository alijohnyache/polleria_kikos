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

class OrderModel {
  final String id;
  final String clientId;
  final String? riderId;
  final DateTime date;
  final String status; // pendiente, en_cocina, en_lote, en_ruta, entregado
  final double total;
  final List<OrderItem> items;
  final String zone;

  OrderModel({
    required this.id,
    required this.clientId,
    this.riderId,
    required this.date,
    required this.status,
    required this.total,
    required this.items,
    required this.zone,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data, String documentId) {
    var itemsData = data['items'] as List<dynamic>? ?? [];
    List<OrderItem> items = itemsData
        .map((item) => OrderItem.fromMap(item as Map<String, dynamic>))
        .toList();

    return OrderModel(
      id: documentId,
      clientId: data['clientId'] ?? '',
      riderId: data['riderId'],
      date: data['date'] != null ? data['date'].toDate() : DateTime.now(),
      status: data['status'] ?? 'pendiente',
      total: (data['total'] ?? 0.0).toDouble(),
      items: items,
      zone: data['zone'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      if (riderId != null) 'riderId': riderId,
      'date': date,
      'status': status,
      'total': total,
      'items': items.map((item) => item.toMap()).toList(),
      'zone': zone,
    };
  }
}
