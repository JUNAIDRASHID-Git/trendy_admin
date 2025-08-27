import 'package:admin_pannel/core/const/const.dart';
import 'package:admin_pannel/core/services/models/product/product_model.dart';
import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/pages/product/bloc/product_bloc.dart';
import 'package:admin_pannel/presentation/pages/product/widgets/buttons/action_btn.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  List<ProductModel> _filteredProducts = [];
  List<ProductModel> _allProducts = [];
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterProducts();
  }

  void _onCategoryChanged(String? category) {
    setState(() {
      _selectedCategory = category;
    });
    _filterProducts();
  }

  void _updateProducts(List<ProductModel> products) {
    _allProducts = products;

    // Extract unique categories
    Set<String> categorySet = {};
    for (var product in products) {
      for (var category in product.categories) {
        categorySet.add(category.ename);
      }
    }
    _categories = categorySet.toList()..sort();

    _filterProducts();
  }

  void _filterProducts() {
    List<ProductModel> filtered = List.from(_allProducts);

    // Apply search filter
    String searchTerm = _searchController.text.toLowerCase().trim();
    if (searchTerm.isNotEmpty) {
      filtered =
          filtered.where((product) {
            return product.eName.toLowerCase().contains(searchTerm) ||
                product.id.toString().contains(searchTerm);
          }).toList();
    }

    // Apply category filter
    if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
      filtered =
          filtered.where((product) {
            return product.categories.any(
              (cat) => cat.ename == _selectedCategory,
            );
          }).toList();
    }

    setState(() {
      _filteredProducts = filtered;
    });
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _selectedCategory = null;
    });
    _filterProducts();
  }

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
              // Update products when state changes
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_allProducts != state.products) {
                  _updateProducts(state.products);
                }
              });

              if (state.products.isEmpty) {
                return const Center(child: Text('No products found.'));
              }

              final double availableWidth = constraints.maxWidth;

              return Column(
                children: [
                  // Search and Filter Section
                  _buildSearchAndFilterSection(isMobile, availableWidth),

                  // Results Info
                  _buildResultsInfo(isMobile),

                  // Header row
                  _buildHeaderBar(isMobile, availableWidth),

                  // List items
                  _buildProductList(isMobile, availableWidth),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget _buildSearchAndFilterSection(bool isMobile, double availableWidth) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (isMobile) ...[
            // Mobile layout - stacked
            _buildSearchField(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildCategoryFilter()),
                const SizedBox(width: 12),
                _buildClearButton(),
              ],
            ),
          ] else ...[
            // Desktop layout - horizontal
            Row(
              children: [
                Expanded(flex: 3, child: _buildSearchField()),
                const SizedBox(width: 16),
                Expanded(flex: 2, child: _buildCategoryFilter()),
                const SizedBox(width: 12),
                _buildClearButton(),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search by product name or ID...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon:
            _searchController.text.isNotEmpty
                ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () => _searchController.clear(),
                )
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: InputDecoration(
        hintText: 'Filter by category',
        prefixIcon: const Icon(Icons.category, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      items: [
        const DropdownMenuItem<String>(
          value: null,
          child: Text('All Categories'),
        ),
        ..._categories.map(
          (category) =>
              DropdownMenuItem<String>(value: category, child: Text(category)),
        ),
      ],
      onChanged: _onCategoryChanged,
    );
  }

  Widget _buildClearButton() {
    final hasFilters =
        _searchController.text.isNotEmpty || _selectedCategory != null;

    return ElevatedButton.icon(
      onPressed: hasFilters ? _clearFilters : null,
      icon: const Icon(Icons.clear_all, size: 18),
      label: const Text('Clear'),
      style: ElevatedButton.styleFrom(
        backgroundColor: hasFilters ? Colors.orange : Colors.grey.shade300,
        foregroundColor: hasFilters ? Colors.white : Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildResultsInfo(bool isMobile) {
    if (_filteredProducts.isEmpty && _allProducts.isNotEmpty) {
      return Container(
        color: Colors.orange.shade50,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.orange.shade700, size: 16),
            const SizedBox(width: 8),
            Text(
              'No products match your search criteria',
              style: TextStyle(
                color: Colors.orange.shade700,
                fontSize: isMobile ? 12 : 14,
              ),
            ),
          ],
        ),
      );
    }

    if (_filteredProducts.isNotEmpty) {
      final hasActiveFilters =
          _searchController.text.isNotEmpty || _selectedCategory != null;
      return Container(
        color: Colors.blue.shade50,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue.shade700, size: 16),
            const SizedBox(width: 8),
            Text(
              hasActiveFilters
                  ? 'Showing ${_filteredProducts.length} of ${_allProducts.length} products'
                  : 'Showing ${_filteredProducts.length} products',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: isMobile ? 12 : 14,
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildHeaderBar(bool isMobile, double availableWidth) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ID Column
          SizedBox(
            width: availableWidth * 0.05,
            child: Text(
              'ID',
              style: TextStyle(
                color: AppColors.fontWhite,
                fontSize: isMobile ? 12 : 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(width: availableWidth * 0.01),

          // Image column
          if (!isMobile) ...[
            SizedBox(
              width: availableWidth * 0.1,
              child: Text(
                'Image',
                style: TextStyle(
                  color: AppColors.fontWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: availableWidth * 0.02),
          ],

          // Name column
          Expanded(
            flex: isMobile ? 3 : 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Name',
                style: TextStyle(
                  color: AppColors.fontWhite,
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Categories column
          if (!isMobile || availableWidth > 600)
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    color: AppColors.fontWhite,
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Stock column (changed from Weight as it shows stock in the original code)
          SizedBox(
            width: availableWidth * (isMobile ? 0.15 : 0.1),
            child: Text(
              'Stock',
              style: TextStyle(
                color: AppColors.fontWhite,
                fontSize: isMobile ? 12 : 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(width: availableWidth * 0.01),

          // Sale Price column
          SizedBox(
            width: availableWidth * (isMobile ? 0.2 : 0.12),
            child: Text(
              'Sale Price',
              style: TextStyle(
                color: AppColors.fontWhite,
                fontSize: isMobile ? 12 : 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(width: availableWidth * 0.01),

          // Actions column
          SizedBox(
            width: availableWidth * (isMobile ? 0.2 : 0.15),
            child: Text(
              'Actions',
              style: TextStyle(
                color: AppColors.fontWhite,
                fontSize: isMobile ? 12 : 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(bool isMobile, double availableWidth) {
    return Expanded(
      child:
          _filteredProducts.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No products available',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  final categoryNames =
                      product.categories.isNotEmpty
                          ? product.categories.map((e) => e.ename).join(', ')
                          : '—';

                  return Container(
                    color: AppColors.secondary,
                    margin: const EdgeInsets.only(bottom: 2),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ID Column
                        SizedBox(
                          width: availableWidth * 0.05,
                          child: Text(
                            product.id.toString(),
                            style: TextStyle(
                              fontSize: isMobile ? 12 : 14,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(width: availableWidth * 0.01),

                        // Image Column
                        if (!isMobile) ...[
                          SizedBox(
                            width: availableWidth * 0.1,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: CachedNetworkImage(
                                    imageUrl: baseHost + product.image,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (context, url) => Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: const Center(
                                            child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          ),
                                        ),
                                    errorWidget:
                                        (context, url, error) => Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.image_not_supported,
                                            size: 24,
                                            color: Colors.grey,
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: availableWidth * 0.02),
                        ],

                        // Name Column
                        Expanded(
                          flex: isMobile ? 3 : 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              product.eName,
                              style: TextStyle(
                                fontSize: isMobile ? 12 : 14,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),

                        // Categories Column
                        if (!isMobile || availableWidth > 600)
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                categoryNames.toUpperCase(),
                                style: TextStyle(
                                  fontSize: isMobile ? 11 : 13,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),

                        // Stock Column
                        SizedBox(
                          width: availableWidth * (isMobile ? 0.15 : 0.1),
                          child: Text(
                            '${product.stock}',
                            style: TextStyle(
                              fontSize: isMobile ? 11 : 13,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(width: availableWidth * 0.01),

                        // Sale Price Column
                        SizedBox(
                          width: availableWidth * (isMobile ? 0.2 : 0.12),
                          child: Text(
                            "${product.salePrice.toDouble()} SAR",
                            style: TextStyle(
                              fontSize: isMobile ? 11 : 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.green[700],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(width: availableWidth * 0.01),

                        // Action Buttons
                        SizedBox(
                          width: availableWidth * (isMobile ? 0.2 : 0.15),
                          child: actionButton(isMobile, product, context),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
