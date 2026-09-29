import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/app_colors.dart';
import '../services/cart_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _placeOrder(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to place an order')),
      );
      return;
    }

    final cart = CartService.instance;
    if (cart.items.isEmpty) return;

    await FirebaseFirestore.instance.collection('orders').add({
      'userId': user.uid,
      'items': cart.items
          .map((item) => {
                'medicineId': item.medicineId,
                'name': item.name,
                'qty': item.quantity,
                'price': item.price,
              })
          .toList(),
      'status': 'pending',
      'totalAmount': cart.total,
      'createdAt': FieldValue.serverTimestamp(),
    });

    cart.clear();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: ValueListenableBuilder(
        valueListenable: cart.itemsNotifier,
        builder: (context, items, _) {
          if (items.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text('UGX ${item.price.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                        color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => cart.updateQuantity(
                                item.medicineId, item.quantity - 1),
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => cart.updateQuantity(
                                item.medicineId, item.quantity + 1),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total',
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text('UGX ${cart.total.toStringAsFixed(0)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _placeOrder(context),
                        child: const Text('Place order'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}