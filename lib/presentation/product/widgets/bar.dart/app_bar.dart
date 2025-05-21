import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/product/widgets/buttons/add_product_btn.dart';
import 'package:admin_pannel/presentation/product/widgets/buttons/import_product_btn.dart';
import 'package:flutter/material.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: greyColor,
    title: Text(
      "All Products",
      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
    ),
    actions: [
      addProductBtn(context),
      SizedBox(width: 16),
      importProductBtn(context),
      SizedBox(width: 16),
    ],
  );
}
