import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/pages/product/pages/add/add_product.dart';
import 'package:admin_pannel/presentation/pages/product/pages/category/category.dart';
import 'package:admin_pannel/presentation/pages/product/pages/import/import_products.dart';
import 'package:admin_pannel/presentation/widgets/buttons/secondary.dart';
import 'package:admin_pannel/presentation/widgets/text/heading_text.dart';
import 'package:flutter/material.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      side: BorderSide(color: AppColors.primary),
    ),
    title: headingText("Products",AppColors.fontWhite),
    actions: [
      secondaryBtn(
        action: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryPage()),
          );
        },
        text: 'Product Category',
        btnColor: AppColors.blueColor,
      ),
      SizedBox(width: 16),
      secondaryBtn(
        action: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
        },
        icon: Icon(Icons.add, color: AppColors.fontWhite),
        text: 'New Product',
        btnColor: AppColors.blueColor,
      ),
      SizedBox(width: 16),
      secondaryBtn(
        action: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ExcelUploadWidget()),
          );
        },
        icon: Icon(Icons.import_export, color: AppColors.fontWhite),
        text: 'Import',
        btnColor: AppColors.blueColor,
      ),
      SizedBox(width: 16),
    ],
  );
}
