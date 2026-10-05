class ReservationModel {
  final String id;
  final String clientId;
  final String tableId;
  final int persons;
  final DateTime reservationTime;
  final String status; // en_espera, en_mesa, liberada
  final int toleranceMinutes;
  final DateTime? entryTime;

  ReservationModel({
    required this.id,
    required this.clientId,
    required this.tableId,
    required this.persons,
    required this.reservationTime,
    required this.status,
    this.toleranceMinutes = 15,
    this.entryTime,
  });

  factory ReservationModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ReservationModel(
      id: documentId,
      clientId: data['clientId'] ?? '',
      tableId: data['tableId'] ?? '',
      persons: data['persons'] ?? 1,
      reservationTime: data['reservationTime'] != null 
          ? data['reservationTime'].toDate() 
          : DateTime.now(),
      status: data['status'] ?? 'en_espera',
      toleranceMinutes: data['toleranceMinutes'] ?? 15,
      entryTime: data['entryTime']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'tableId': tableId,
      'persons': persons,
      'reservationTime': reservationTime,
      'status': status,
      'toleranceMinutes': toleranceMinutes,
      if (entryTime != null) 'entryTime': entryTime,
    };
  }
}
