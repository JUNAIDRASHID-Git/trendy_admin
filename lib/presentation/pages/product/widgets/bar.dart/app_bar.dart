import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/pages/product/pages/add/add_product.dart';
import 'package:admin_pannel/presentation/pages/product/pages/import/import_products.dart';
import 'package:flutter/material.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    toolbarHeight: 72,
    title: Text(
      'Products',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.grey[900],
        letterSpacing: -0.5,
      ),
    ),
    actions: [
      // Import Button
      _MinimalButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ExcelUploadWidget()),
          );
        },
        icon: Icons.upload_outlined,
        label: 'Import',
        isOutlined: true,
      ),
      SizedBox(width: 12),

      // New Product Button
      _MinimalButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
        },
        icon: Icons.add_rounded,
        label: 'New Product',
        isOutlined: false,
      ),
      SizedBox(width: 24),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1),
      child: Container(height: 1, color: Colors.grey[200]),
    ),
  );
}

class _MinimalButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final bool isOutlined;

  const _MinimalButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isOutlined ? Colors.transparent : AppColors.blueColor,
            border:
                isOutlined
                    ? Border.all(color: Colors.grey[300]!, width: 1.5)
                    : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isOutlined ? Colors.grey[700] : Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isOutlined ? Colors.grey[700] : Colors.white,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
