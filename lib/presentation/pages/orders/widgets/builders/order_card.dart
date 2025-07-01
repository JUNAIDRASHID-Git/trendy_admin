import 'package:admin_pannel/core/services/models/order/order.dart';
import 'package:admin_pannel/presentation/pages/orders/widgets/builders/order_details.dart';
import 'package:admin_pannel/presentation/pages/orders/widgets/builders/status_chips.dart';
import 'package:flutter/material.dart';

Widget buildOrderCard(OrderModel order, BuildContext context) {
  return Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: ExpansionTile(
      title: Row(
        children: [
          Text(
            '#${order.id}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 8),
          buildStatusChip(order.status),
          const Spacer(),
          Text(
            '\$${order.totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(order.user.name),
          Text(order.createdAt.toString().substring(0, 16)),
        ],
      ),
      children: [buildOrderDetails(order, context)],
    ),
  );
}
