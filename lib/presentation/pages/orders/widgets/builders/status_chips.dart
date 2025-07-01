import 'package:flutter/material.dart';

Widget buildStatusChip(String status) {
    final colors = {
      'pending': Colors.orange,
      'confirmed': Colors.blue,
      'shipped': Colors.purple,
      'delivered': Colors.green,
      'cancelled': Colors.red,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colors[status]?.withOpacity(0.1),
        border: Border.all(color: colors[status] ?? Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(fontSize: 10, color: colors[status]),
      ),
    );
  }