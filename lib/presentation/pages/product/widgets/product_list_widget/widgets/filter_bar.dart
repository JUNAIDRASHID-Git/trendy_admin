// -----------------------------------------------------------------------------
// Filter Bar
// -----------------------------------------------------------------------------
import 'package:admin_pannel/core/theme/colors.dart';
import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final List<String> categories;
  final String? selectedCategory;
  final VoidCallback onSearchChanged;
  final ValueChanged<String?> onCategoryChanged;
  final VoidCallback onClearFilters;

  const FilterBar({
    super.key,
    required this.searchController,
    required this.categories,
    required this.selectedCategory,
    required this.onSearchChanged,
    required this.onCategoryChanged,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Material(
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSearchField(),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildCategoryDropdown()),
            const SizedBox(width: 8),
            _buildClearButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(flex: 3, child: _buildSearchField()),
        const SizedBox(width: 16),
        Expanded(flex: 2, child: _buildCategoryDropdown()),
        const SizedBox(width: 12),
        _buildClearButton(),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      onChanged: (_) => onSearchChanged(),
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: 'Search by name or ID...',
        prefixIcon: const Icon(Icons.search_rounded, color: Colors.grey),
        suffixIcon:
            searchController.text.isNotEmpty
                ? IconButton(
                  icon: const Icon(Icons.clear_rounded, color: Colors.grey),
                  onPressed: () {
                    searchController.clear();
                    onSearchChanged();
                  },
                )
                : null,
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      decoration: InputDecoration(
        hintText: 'All Categories',
        prefixIcon: const Icon(Icons.category_outlined, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      items: [
        const DropdownMenuItem(value: null, child: Text('All Categories')),
        ...categories.map(
          (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
        ),
      ],
      onChanged: onCategoryChanged,
    );
  }

  Widget _buildClearButton() {
    final hasFilters =
        searchController.text.isNotEmpty || selectedCategory != null;
    return ElevatedButton.icon(
      onPressed: hasFilters ? onClearFilters : null,
      icon: const Icon(Icons.filter_alt_off_rounded, size: 18),
      label: const Text('Clear'),
      style: ElevatedButton.styleFrom(
        backgroundColor: hasFilters ? AppColors.primary : Colors.grey.shade300,
        foregroundColor: hasFilters ? Colors.white : Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    );
  }
}
