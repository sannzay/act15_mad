import 'package:flutter/material.dart';
import '../models/item.dart';

class AddEditItemScreen extends StatelessWidget {
  final Item? item;

  const AddEditItemScreen({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item == null ? 'Add Item' : 'Edit Item'),
      ),
      body: const Center(
        child: Text('Add/Edit Item Screen - Coming in Stage 5'),
      ),
    );
  }
}

