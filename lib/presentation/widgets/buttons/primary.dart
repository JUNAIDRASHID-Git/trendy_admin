import 'package:admin_pannel/core/theme/colors.dart';
import 'package:flutter/material.dart';

InkWell primaryBtn({required Function()? action, required String text}) {
  return InkWell(
    onTap: action,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, color: AppColors.fontWhite, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: AppColors.fontWhite,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}
