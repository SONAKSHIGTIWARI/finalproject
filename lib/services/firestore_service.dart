import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch product by barcode field (not document ID)
  Future<Map<String, dynamic>?> getProductByBarcode(String barcode) async {
    try {
      final query = await _db
          .collection('products')
          .where('barcode', isEqualTo: barcode)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        return query.docs.first.data();
      } else {
        print('ℹ️ No product found for barcode: $barcode');
        return null;
      }
    } catch (e) {
      print('❌ Error fetching product: $e');
      return null;
    }
  }
}
