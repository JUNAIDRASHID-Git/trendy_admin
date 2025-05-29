import 'package:admin_pannel/presentation/pages/product/pages/category/widgets/builder.dart';
import 'package:admin_pannel/presentation/widgets/buttons/primary.dart';
import 'package:admin_pannel/presentation/widgets/text/heading_text.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        title: headingText("Categories"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: primaryBtn(action: () {}),
          ),
        ],
      ),
      body: catogoryList(),
    );
  }
}
