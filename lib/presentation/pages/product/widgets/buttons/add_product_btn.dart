import 'package:admin_pannel/presentation/pages/product/pages/add/add_product.dart';
import 'package:flutter/material.dart';

ElevatedButton addProductBtn(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent[400],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddProductPage()),
      );
    },
    child: const Row(
      children: [
        Icon(Icons.add, color: Colors.white),
        SizedBox(width: 8),
        Text('Add Product', style: TextStyle(color: Colors.white)),
      ],
    ),
  );
}
