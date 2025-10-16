import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (product['image'] != null)
              Image.network(product['image'], height: 150),
            SizedBox(height: 10),
            Text(product['name'] ?? 'Unknown Product',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Eco Score: ${product['total_eco_score']}"),
            Text("Packaging Type: ${product['packaging_type']}"),
            Text("Ingredient: ${product['impacting_ingredient']}"),
          ],
        ),
      ),
    );
  }
}
