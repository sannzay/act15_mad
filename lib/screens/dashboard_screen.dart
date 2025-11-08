import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/item.dart';
import 'add_edit_item_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: StreamBuilder<List<Item>>(
        stream: firestoreService.getItemsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.analytics_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No data available',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final items = snapshot.data!;
          final totalItems = items.length;
          final totalInventoryValue = items.fold<double>(
            0.0,
            (sum, item) => sum + (item.quantity * item.price),
          );
          final outOfStockItems = items.where((item) => item.quantity <= 0).toList();

          final categoryCounts = <String, int>{};
          for (final item in items) {
            categoryCounts[item.category] = (categoryCounts[item.category] ?? 0) + 1;
          }
          final sortedCategories = categoryCounts.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.inventory_2,
                          size: 48,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Items',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              totalItems.toString(),
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.attach_money,
                          size: 48,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Inventory Value',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '\$${totalInventoryValue.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.warning,
                              size: 24,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Out of Stock Items',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${outOfStockItems.length}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (outOfStockItems.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'No out-of-stock items',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        else
                          ...outOfStockItems.map((item) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.cancel, color: Colors.red),
                              title: Text(
                                item.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('Category: ${item.category}'),
                              trailing: Text(
                                'Qty: ${item.quantity}',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditItemScreen(item: item),
                                  ),
                                );
                              },
                            );
                          }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.category,
                              size: 24,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Items by Category',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (sortedCategories.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'No categories available',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        else
                          ...sortedCategories.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      entry.key,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${entry.value}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

