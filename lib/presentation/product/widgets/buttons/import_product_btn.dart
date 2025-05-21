 import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/product/pages/import_products.dart';
import 'package:flutter/material.dart';

ElevatedButton importProductBtn(BuildContext context) {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExcelUploadWidget(),
                ),
              );
            },
            child: Row(
              children: [
                Icon(Icons.import_export, color: fontWhite),
                SizedBox(width: 8),
                Text('Import Product', style: TextStyle(color: fontWhite)),
              ],
            ),
          );
  }