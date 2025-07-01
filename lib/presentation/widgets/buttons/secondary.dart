import 'package:admin_pannel/core/theme/colors.dart';
import 'package:flutter/material.dart';

ElevatedButton secondaryBtn({
  required String text,
  required Function()? action,
  Icon? icon,
  required Color? btnColor,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: btnColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    ),
    onPressed: action,
    child: Row(
      children: [
        if (icon != null) icon,
        if (icon != null) SizedBox(width: 8),
        Text(text, style: TextStyle(color: AppColors.fontWhite)),
      ],
    ),
  );
}
