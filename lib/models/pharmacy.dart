class Pharmacy {
  final String id;
  final String name;
  final String address;
  final String phone;
  final bool verified;

  Pharmacy({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.verified,
  });

  factory Pharmacy.fromMap(String id, Map<String, dynamic> map) {
    return Pharmacy(
      id: id,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      verified: map['verified'] ?? false,
    );
  }
}