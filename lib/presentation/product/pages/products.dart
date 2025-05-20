import 'package:admin_pannel/core/const/const.dart';
import 'package:admin_pannel/presentation/product/pages/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(FetchProduct()),
      child: Scaffold(
        appBar: AppBar(title: const Text("All Products")),
        body: LayoutBuilder(
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

                  // Wrap DataTable in horizontal scroll on small screens
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: isMobile ? 600 : constraints.maxWidth,
                        ),
                        child: DataTable(
                          columnSpacing: isMobile ? 20 : 60,
                          dataRowMinHeight: isMobile ? 60 : 80,
                          dataRowMaxHeight: isMobile ? 100 : 150,
                          columns: const [
                            DataColumn(label: Text('No.')),
                            DataColumn(label: Text('Image')),
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Categories')),
                            DataColumn(label: Text('Weight')),
                            DataColumn(label: Text('Created At')),
                          ],
                          rows: List<DataRow>.generate(products.length, (
                            index,
                          ) {
                            final product = products[index];

                            return DataRow(
                              cells: [
                                DataCell(Text('${index + 1}')),
                                DataCell(
                                  SizedBox(
                                    width: isMobile ? 40 : 60,
                                    height: isMobile ? 60 : 80,
                                    child: Image.network(
                                      "$baseHost${product.image}",
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return const Icon(
                                          Icons.image_not_supported,
                                          size: 24,
                                        );
                                      },
                                      loadingBuilder: (
                                        context,
                                        child,
                                        progress,
                                      ) {
                                        if (progress == null) return child;
                                        return const Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      fontSize: isMobile ? 12 : 14,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    product.categories.isNotEmpty
                                        ? product.categories.join(', ')
                                        : '—',
                                    style: TextStyle(
                                      fontSize: isMobile ? 12 : 14,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '${product.weight} kg',
                                    style: TextStyle(
                                      fontSize: isMobile ? 12 : 14,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '${product.createdAt.year}-${product.createdAt.month.toString().padLeft(2, '0')}-${product.createdAt.day.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                      fontSize: isMobile ? 12 : 14,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
