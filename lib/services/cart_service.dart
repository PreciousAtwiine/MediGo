import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartService {
  CartService._internal();
  static final CartService instance = CartService._internal();

  final ValueNotifier<List<CartItem>> itemsNotifier = ValueNotifier([]);

  List<CartItem> get items => itemsNotifier.value;

  double get total =>
      items.fold(0, (sum, item) => sum + item.subtotal);

  void addItem(String medicineId, String name, double price) {
    final existingIndex =
        items.indexWhere((item) => item.medicineId == medicineId);

    if (existingIndex >= 0) {
      items[existingIndex].quantity += 1;
    } else {
      items.add(CartItem(medicineId: medicineId, name: name, price: price));
    }
    itemsNotifier.value = List.from(items);
  }

  void updateQuantity(String medicineId, int quantity) {
    if (quantity <= 0) {
      removeItem(medicineId);
      return;
    }
    final index = items.indexWhere((item) => item.medicineId == medicineId);
    if (index >= 0) {
      items[index].quantity = quantity;
      itemsNotifier.value = List.from(items);
    }
  }

  void removeItem(String medicineId) {
    items.removeWhere((item) => item.medicineId == medicineId);
    itemsNotifier.value = List.from(items);
  }

  void clear() {
    itemsNotifier.value = [];
  }
}