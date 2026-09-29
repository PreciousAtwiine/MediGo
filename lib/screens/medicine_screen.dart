import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/firestore_service.dart';
import '../models/medicine.dart';
import 'cart.dart';
import '../services/cart_service.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Medicine',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Browse available medicine',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search medicine',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryDark,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.shopping_cart_outlined,
                      color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 10),
              const CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.accent,
                child: Icon(Icons.person, color: AppColors.primaryDark),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: StreamBuilder<List<Medicine>>(
              stream: firestoreService.streamMedicines(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final medicines = snapshot.data!;
                if (medicines.isEmpty) {
                  return const Center(child: Text('No medicines yet'));
                }
                return GridView.builder(
                  itemCount: medicines.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final med = medicines[index];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    AppColors.accent.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(med.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('UGX ${med.price.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                      color: AppColors.textSecondary)),
                              GestureDetector(
                                onTap: () => CartService.instance
                                    .addItem(med.id, med.name, med.price),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryDark,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.add,
                                      color: Colors.white, size: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}