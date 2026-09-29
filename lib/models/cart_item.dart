class CartItem {
  final String medicineId;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.medicineId,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  double get subtotal => price * quantity;
}