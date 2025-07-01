import 'package:admin_pannel/core/services/models/product/product_model.dart';
import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/pages/product/bloc/product_bloc.dart';
import 'package:admin_pannel/presentation/pages/product/pages/edit/edit_prodoct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget actionButton(
  bool isMobile,
  ProductModel product,
  BuildContext mainContext,
) {
  return PopupMenuButton<String>(
    offset: const Offset(0, 30),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Icon(
      Icons.more_vert,
      color: AppColors.fontBlack,
      size: isMobile ? 18 : 20,
    ),
    itemBuilder:
        (context) => [
          PopupMenuItem<String>(
            value: 'edit',
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: AppColors.primary,
                  size: isMobile ? 18 : 20,
                ),
                const SizedBox(width: 8),
                const Text('Edit'),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, color: Colors.red, size: isMobile ? 18 : 20),
                const SizedBox(width: 8),
                const Text('Delete'),
              ],
            ),
          ),
        ],
    onSelected: (value) {
      if (value == 'edit') {
        Navigator.push(
          mainContext,
          MaterialPageRoute(
            builder: (context) => EditProductPage(product: product),
          ),
        );
      } else if (value == 'delete') {
        // Delete action
        showDialog(
          context: mainContext,
          builder:
              (context) => AlertDialog(
                title: const Text('Delete Product'),
                content: Text(
                  'Are you sure you want to delete "${product.eName}"?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement delete functionality
                      mainContext.read<ProductBloc>().add(
                        ProductDeleteEvent(product.id!),
                      );

                      Navigator.of(context).pop();

                      // Show success message
                      ScaffoldMessenger.of(mainContext).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Product deleted successfully'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
        );
      }
    },
  );
}
