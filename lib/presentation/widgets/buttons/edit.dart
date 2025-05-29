import 'package:flutter/material.dart';

InkWell editBtn({required Function()? action}) {
  return InkWell(
    onTap: action,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.edit_outlined, size: 18, color: Colors.blue[600]),
    ),
  );
}
