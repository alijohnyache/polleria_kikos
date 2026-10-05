import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import '../models/order.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Products
  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Product.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> addProduct(Product product) {
    return _db.collection('products').add(product.toMap());
  }

  Future<void> updateProduct(Product product) {
    return _db.collection('products').doc(product.id).update(product.toMap());
  }

  Future<void> deleteProduct(String id) {
    return _db.collection('products').doc(id).delete();
  }

  // Orders
  Stream<List<AppOrder>> getUserOrders(String userId) {
    return _db
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => AppOrder.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> placeOrder(AppOrder order) {
    return _db.collection('orders').add(order.toMap());
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) {
    return _db.collection('orders').doc(orderId).update({'status': newStatus});
  }
}
