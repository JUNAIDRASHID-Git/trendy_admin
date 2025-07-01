import 'package:admin_pannel/core/services/models/product/product_model.dart';
import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/pages/product/widgets/buttons/action_btn.dart';
import 'package:flutter/material.dart';

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
        final categoryNames = product.categories.isNotEmpty
            ? product.categories.map((e) => e.ename).join(', ')
            : '—';

        return Container(
          color: AppColors.secondary,
          margin: const EdgeInsets.only(bottom: 2),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                        child: Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 24,
                              color: Colors.grey,
                            ),
                          ),
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(4),
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
                            );
                          },
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
                    padding: const EdgeInsets.symmetric(horizontal: 8),
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

              // Weight Column
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
                child: actionButton(isMobile, product, mainContext),
              ),
            ],
          ),
        );
      },
    ),
  );
}
