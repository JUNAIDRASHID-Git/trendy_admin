import 'package:admin_pannel/core/services/models/product/product_model.dart';
import 'package:admin_pannel/presentation/pages/product/bloc/product_bloc.dart';
import 'package:admin_pannel/presentation/pages/product/widgets/product_list_widget/widgets/filter_bar.dart';
import 'package:admin_pannel/presentation/pages/product/widgets/product_list_widget/widgets/product_grid.dart';
import 'package:admin_pannel/presentation/pages/product/widgets/product_list_widget/widgets/result_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final _searchController = TextEditingController();
  String? _selectedCategory;
  List<ProductModel> _filteredProducts = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts(List<ProductModel> allProducts) {
    final search = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredProducts =
          allProducts.where((product) {
            final matchesSearch =
                search.isEmpty ||
                product.eName.toLowerCase().contains(search) ||
                product.id.toString().contains(search);
            final matchesCategory =
                _selectedCategory == null ||
                product.categories.any((cat) => cat.ename == _selectedCategory);
            return matchesSearch && matchesCategory;
          }).toList();
    });
  }

  List<String> _getCategories(List<ProductModel> products) {
    return products
        .expand((p) => p.categories.map((c) => c.ename))
        .toSet()
        .toList()
      ..sort();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProductError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 72, color: Colors.red.shade300),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          );
        }

        if (state is! ProductLoaded || state.products.isEmpty) {
          return _buildEmptyState();
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _filterProducts(state.products);
        });

        return Column(
          children: [
            FilterBar(
              searchController: _searchController,
              categories: _getCategories(state.products),
              selectedCategory: _selectedCategory,
              onSearchChanged: () => _filterProducts(state.products),
              onCategoryChanged: (cat) {
                setState(() => _selectedCategory = cat);
                _filterProducts(state.products);
              },
              onClearFilters: () {
                _searchController.clear();
                setState(() => _selectedCategory = null);
                _filterProducts(state.products);
              },
            ),
            ResultsInfo(
              totalProducts: state.products.length,
              filteredCount: _filteredProducts.length,
              hasFilters:
                  _searchController.text.isNotEmpty ||
                  _selectedCategory != null,
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child:
                    _filteredProducts.isEmpty
                        ? _buildEmptyState(isFiltered: true)
                        : ProductGrid(products: _filteredProducts),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState({bool isFiltered = false}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isFiltered
                  ? Icons.search_off_rounded
                  : Icons.inventory_2_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              isFiltered
                  ? 'No products match your filters'
                  : 'No products available',
              style: TextStyle(fontSize: 17, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
