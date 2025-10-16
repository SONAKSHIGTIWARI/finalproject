import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController barcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    testFirestore();
  }

  // Firestore connection test
  void testFirestore() async {
    try {
      final db = FirebaseFirestore.instance;
      final doc = await db.collection('products').limit(1).get();
      if (doc.docs.isNotEmpty) {
        print("🔥 Fetched sample: ${doc.docs.first.data()}");
      } else {
        print("⚠️ No documents found in 'products' collection");
      }
    } catch (e) {
      print("❌ Firestore Error: $e");
    }
  }

  // Barcode search
  void fetchProduct(String barcode) async {
    try {
      final db = FirebaseFirestore.instance;
      final snapshot = await db
          .collection('products')
          .where('barcode', isEqualTo: barcode)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        print("✅ Product found: $data");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(productData: data),
          ),
        );
      } else {
        print("⚠️ No product found for barcode $barcode");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No product found!")),
        );
      }
    } catch (e) {
      print("❌ Error fetching product: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ecomitra Lab")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: barcodeController,
              decoration: const InputDecoration(
                labelText: "Enter barcode",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                fetchProduct(value);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchProduct(barcodeController.text);
              },
              child: const Text("Search"),
            ),
          ],
        ),
      ),
    );
  }
}
