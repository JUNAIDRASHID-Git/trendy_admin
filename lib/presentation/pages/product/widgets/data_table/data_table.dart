import 'package:admin_pannel/presentation/pages/product/bloc/product_bloc.dart';
import 'package:admin_pannel/presentation/pages/product/widgets/bar.dart/header_bar.dart';
import 'package:admin_pannel/presentation/pages/product/widgets/product_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductError) {
              return Center(child: Text("Error: ${state.message}"));
            } else if (state is ProductLoaded) {
              final products = state.products;

              if (products.isEmpty) {
                return const Center(child: Text('No products found.'));
              }

              // Calculate flexible widths based on available space
              final double availableWidth = constraints.maxWidth;

              // Header for the list (column titles)
              return Column(
                children: [
                  // Header row
                  headerBar(isMobile, availableWidth),
                  // List items
                  productListWidget(
                    products,
                    isMobile,
                    availableWidth,
                    context,
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
