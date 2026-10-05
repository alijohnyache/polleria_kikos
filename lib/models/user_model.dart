class UserModel {
  final String id;
  final String role; // cliente, admin, cocina, rider
  final String? phone; // Para clientes
  final String? dni; // Para personal
  final String name;
  final String? address;

  UserModel({
    required this.id,
    required this.role,
    required this.name,
    this.phone,
    this.dni,
    this.address,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      role: data['role'] ?? 'cliente',
      name: data['name'] ?? '',
      phone: data['phone'],
      dni: data['dni'],
      address: data['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'name': name,
      if (phone != null) 'phone': phone,
      if (dni != null) 'dni': dni,
      if (address != null) 'address': address,
    };
  }
}
