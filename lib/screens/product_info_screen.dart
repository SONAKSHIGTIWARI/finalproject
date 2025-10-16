import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../widgets/product_card.dart';

class ProductInfoScreen extends StatefulWidget {
  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  final TextEditingController _barcodeController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  Map<String, dynamic>? productData;
  bool isLoading = false;

  void fetchProduct() async {
    final barcode = _barcodeController.text.trim();
    if (barcode.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter a barcode")));
      return;
    }

    setState(() => isLoading = true);

    final data = await _firestoreService.getProductByBarcode(barcode);

    setState(() {
      productData = data;
      isLoading = false;
    });

    if (data == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No product found!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("🌱 Ecomitra Product Info"),
        backgroundColor: Colors.green.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _barcodeController,
              decoration: InputDecoration(
                labelText: "Enter Barcode",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: fetchProduct,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            if (isLoading)
              CircularProgressIndicator()
            else if (productData != null)
              ProductCard(product: productData!)
            else
              Text("🔍 Enter a barcode to see details."),
          ],
        ),
      ),
    );
  }
}
