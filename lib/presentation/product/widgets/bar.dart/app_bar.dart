import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/product/widgets/buttons/add_product_btn.dart';
import 'package:admin_pannel/presentation/product/widgets/buttons/import_product_btn.dart';
import 'package:flutter/material.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      side: BorderSide(color: AppColors.primary),
    ),
    title: Text(
      "All Products",
      style: TextStyle(color: AppColors.fontWhite, fontWeight: FontWeight.bold),
    ),
    actions: [
      addProductBtn(context),
      SizedBox(width: 16),
      importProductBtn(context),
      SizedBox(width: 16),
    ],
  );
}
