import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item.dart';

class FirestoreService {
  final CollectionReference _itemsCollection =
      FirebaseFirestore.instance.collection('items');

  Future<void> addItem(Item item) async {
    try {
      await _itemsCollection.add(item.toMap());
    } on FirebaseException catch (e) {
      throw Exception('Failed to add item: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw Exception('Failed to add item: $e');
    }
  }

  Stream<List<Item>> getItemsStream() {
    try {
      return _itemsCollection.snapshots().map((snapshot) {
        try {
          return snapshot.docs
              .map((doc) {
                try {
                  return Item.fromMap(
                      doc.id, doc.data() as Map<String, dynamic>);
                } catch (e) {
                  return null;
                }
              })
              .where((item) => item != null)
              .cast<Item>()
              .toList();
        } catch (e) {
          return <Item>[];
        }
      }).handleError((error) {
        throw Exception('Failed to load items: $error');
      });
    } catch (e) {
      throw Exception('Failed to initialize items stream: $e');
    }
  }

  Future<void> updateItem(Item item) async {
    if (item.id == null) {
      throw ArgumentError('Item must have an id to update');
    }
    try {
      await _itemsCollection.doc(item.id).update(item.toMap());
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw Exception('Item not found. It may have been deleted.');
      }
      throw Exception('Failed to update item: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw Exception('Failed to update item: $e');
    }
  }

  Future<void> deleteItem(String itemId) async {
    if (itemId.isEmpty) {
      throw ArgumentError('Item ID cannot be empty');
    }
    try {
      await _itemsCollection.doc(itemId).delete();
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw Exception('Item not found. It may have already been deleted.');
      }
      throw Exception('Failed to delete item: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw Exception('Failed to delete item: $e');
    }
  }
}

