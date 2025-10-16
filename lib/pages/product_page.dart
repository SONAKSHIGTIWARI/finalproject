import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> productData;
  const ProductPage({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Product Name: ${productData['name'] ?? 'N/A'}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Barcode: ${productData['barcode'] ?? 'N/A'}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Carbon Footprint: ${productData['carbon'] ?? 'N/A'}",
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
