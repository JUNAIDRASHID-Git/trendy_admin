import 'package:admin_pannel/core/const/const.dart';
import 'package:admin_pannel/core/services/models/product_model.dart';
import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/product/bloc/product_bloc.dart';
import 'package:admin_pannel/presentation/product/pages/edit_prodoct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Expanded productListWidget(
  List<ProductModel> products,
  bool isMobile,
  double availableWidth,
  BuildContext mainContext,
) {
  return Expanded(
    child: ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          color: index % 2 == 0 ? greyColor : greyColor.withOpacity(0.7),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              // No column
              SizedBox(
                width: isMobile ? availableWidth * 0.08 : availableWidth * 0.05,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(fontSize: isMobile ? 12 : 14),
                ),
              ),

              // Image column
              SizedBox(
                width: isMobile ? availableWidth * 0.15 : availableWidth * 0.1,
                child: SizedBox(
                  width: isMobile ? 40 : 60,
                  height: isMobile ? 60 : 80,
                  child: Image.network(
                    "$baseHost${product.image}",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 24);
                    },
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Name column
              SizedBox(
                width: isMobile ? availableWidth * 0.25 : availableWidth * 0.2,
                child: Text(
                  product.eName,
                  style: TextStyle(fontSize: isMobile ? 12 : 14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),

              // Categories column
              SizedBox(
                width: isMobile ? availableWidth * 0.25 : availableWidth * 0.3,
                child: Text(
                  product.categories.isNotEmpty
                      ? product.categories.join(', ')
                      : '—',
                  style: TextStyle(fontSize: isMobile ? 12 : 14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),

              // Weight column
              SizedBox(
                width: isMobile ? availableWidth * 0.12 : availableWidth * 0.15,
                child: Text(
                  '${product.weight} kg',
                  style: TextStyle(fontSize: isMobile ? 12 : 14),
                ),
              ),

              // Actions column
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Edit action
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => EditProductPage(product: product),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: primaryColor,
                        size: isMobile ? 18 : 20,
                      ),
                      tooltip: 'Edit',
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: () {
                        // Delete action
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text('Delete Product'),
                                content: Text(
                                  'Are you sure you want to delete "${product.eName}"?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Implement delete functionality
                                      mainContext.read<ProductBloc>().add(
                                        ProductDeleteEvent(product.id),
                                      );
                                      // Show success message
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.lightGreen,
                                          content: Text('Product deleted'),
                                        ),
                                      );

                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: isMobile ? 18 : 20,
                      ),
                      tooltip: 'Delete',
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
