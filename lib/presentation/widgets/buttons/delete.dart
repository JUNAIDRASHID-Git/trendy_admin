import 'package:flutter/material.dart';

InkWell deleteBtn({required Function()? action}) {
  return InkWell(
    onTap: action,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.delete_outline, size: 18, color: Colors.red[600]),
    ),
  );
}
