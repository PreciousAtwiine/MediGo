class Driver {
  final String uid;
  final String name;
  final String phone;
  final bool available;
  final String vehicleType;

  Driver({
    required this.uid,
    required this.name,
    required this.phone,
    required this.available,
    required this.vehicleType,
  });

  factory Driver.fromMap(String uid, Map<String, dynamic> map) {
    return Driver(
      uid: uid,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      available: map['available'] ?? false,
      vehicleType: map['vehicleType'] ?? '',
    );
  }
}