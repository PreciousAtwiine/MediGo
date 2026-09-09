class Medicine {
  final String id;
  final String name;
  final String pharmacyId;
  final double price;
  final int stock;
  final bool requiresPrescription;
  final String category;

  Medicine({
    required this.id,
    required this.name,
    required this.pharmacyId,
    required this.price,
    required this.stock,
    required this.requiresPrescription,
    required this.category,
  });

  factory Medicine.fromMap(String id, Map<String, dynamic> map) {
    return Medicine(
      id: id,
      name: map['name'] ?? '',
      pharmacyId: map['pharmacyId'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      stock: map['stock'] ?? 0,
      requiresPrescription: map['requiresPrescription'] ?? false,
      category: map['category'] ?? '',
    );
  }
}