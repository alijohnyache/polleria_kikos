import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../models/reservation_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- Users ---
  Future<UserModel?> getUserByPhone(String phone) async {
    final snapshot = await _db.collection('users').where('phone', isEqualTo: phone).get();
    if (snapshot.docs.isNotEmpty) {
      return UserModel.fromMap(snapshot.docs.first.data(), snapshot.docs.first.id);
    }
    return null;
  }

  Future<UserModel?> getUserByDni(String dni) async {
    final snapshot = await _db.collection('users').where('dni', isEqualTo: dni).get();
    if (snapshot.docs.isNotEmpty) {
      return UserModel.fromMap(snapshot.docs.first.data(), snapshot.docs.first.id);
    }
    return null;
  }

  Future<void> createUser(UserModel user) {
    return _db.collection('users').doc(user.id).set(user.toMap());
  }

  // --- Products (Catalog) ---
  Stream<List<ProductModel>> getProducts({String? category}) {
    Query query = _db.collection('products');
    if (category != null && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }
    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList());
  }

  // --- Orders (Delivery & Despacho) ---
  Stream<List<OrderModel>> getOrdersByStatus(String status) {
    return _db.collection('orders').where('status', isEqualTo: status).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => OrderModel.fromMap(doc.data(), doc.id)).toList());
  }

  Stream<List<OrderModel>> getRiderOrders(String riderId, String status) {
    return _db
        .collection('orders')
        .where('riderId', isEqualTo: riderId)
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => OrderModel.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> placeOrder(OrderModel order) {
    return _db.collection('orders').add(order.toMap());
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) {
    return _db.collection('orders').doc(orderId).update({'status': newStatus});
  }

  Future<void> assignRiderToOrder(String orderId, String riderId) {
    return _db.collection('orders').doc(orderId).update({
      'riderId': riderId,
      'status': 'en_ruta',
    });
  }

  // --- Reservations ---
  Stream<List<ReservationModel>> getReservationsByStatus(String status) {
    return _db.collection('reservations').where('status', isEqualTo: status).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ReservationModel.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> createReservation(ReservationModel reservation) {
    return _db.collection('reservations').add(reservation.toMap());
  }

  Future<void> validateReservationArrival(String reservationId) {
    return _db.collection('reservations').doc(reservationId).update({
      'status': 'en_mesa',
      'entryTime': DateTime.now(),
    });
  }

  Future<void> freeTable(String reservationId) {
    return _db.collection('reservations').doc(reservationId).update({
      'status': 'liberada',
    });
  }
}
