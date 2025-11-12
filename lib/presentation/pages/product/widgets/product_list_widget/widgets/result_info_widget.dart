import 'package:flutter/material.dart';

class ResultsInfo extends StatelessWidget {
  final int totalProducts;
  final int filteredCount;
  final bool hasFilters;

  const ResultsInfo({
    super.key,
    required this.totalProducts,
    required this.filteredCount,
    required this.hasFilters,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.blue.shade800;

    return Container(
      width: double.infinity,
      color: Colors.blue.shade50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: textColor, size: 18),
          const SizedBox(width: 8),
          Text(
            hasFilters
                ? 'Showing $filteredCount of $totalProducts products'
                : '$totalProducts products total',
            style: TextStyle(color: textColor, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
