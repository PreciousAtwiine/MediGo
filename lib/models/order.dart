class OrderItem {
  final String medicineId;
  final String name;
  final int qty;
  final double price;

  OrderItem({
    required this.medicineId,
    required this.name,
    required this.qty,
    required this.price,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      medicineId: map['medicineId'] ?? '',
      name: map['name'] ?? '',
      qty: map['qty'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
    );
  }
}

class MediGoOrder {
  final String id;
  final String userId;
  final String pharmacyId;
  final List<OrderItem> items;
  final String status;
  final double totalAmount;
  final String? driverId;

  MediGoOrder({
    required this.id,
    required this.userId,
    required this.pharmacyId,
    required this.items,
    required this.status,
    required this.totalAmount,
    this.driverId,
  });

  factory MediGoOrder.fromMap(String id, Map<String, dynamic> map) {
    return MediGoOrder(
      id: id,
      userId: map['userId'] ?? '',
      pharmacyId: map['pharmacyId'] ?? '',
      items: (map['items'] as List<dynamic>? ?? [])
          .map((item) => OrderItem.fromMap(item as Map<String, dynamic>))
          .toList(),
      status: map['status'] ?? 'pending',
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      driverId: map['driverId'],
    );
  }
}