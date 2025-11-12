// -----------------------------------------------------------------------------
// Product Grid
// -----------------------------------------------------------------------------
import 'package:admin_pannel/core/services/models/product/product_model.dart';
import 'package:admin_pannel/presentation/pages/product/widgets/product_list_widget/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;
        if (constraints.maxWidth > 1600) {
          crossAxisCount = 5;
        } else if (constraints.maxWidth > 1200) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth > 900) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 2;
        }

        return GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.72,
          ),
          itemCount: products.length,
          itemBuilder:
              (context, index) => ProductCard(product: products[index]),
        );
      },
    );
  }
}
