import 'package:admin_pannel/core/services/models/order/order.dart';
import 'package:admin_pannel/presentation/pages/orders/widgets/builders/action_buttons.dart';
import 'package:admin_pannel/presentation/pages/orders/widgets/builders/info_card.dart';
import 'package:admin_pannel/presentation/pages/orders/widgets/builders/items.dart';
import 'package:flutter/material.dart';

Widget buildOrderDetails(OrderModel order, BuildContext context) {

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: buildInfoCard('Customer', order.user.name)),
            const SizedBox(width: 8),
            Expanded(child: buildInfoCard('Phone', order.user.phone)),
          ],
        ),
        const SizedBox(height: 8),
        buildInfoCard(
          'Address',
          '${order.user.address.street}, ${order.user.address.city}',
        ),
        const SizedBox(height: 16),
        const Text('Items:', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...order.items.map((item) => buildItemRow(item)),
        const SizedBox(height: 16),

        // 🔹 Shipping & Total Section
        Row(
          children: [
            Text(
              "Shipping: \$${order.shippingCost.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),

            const Spacer(),
            Text(
              'Total: \$${order.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),

        const SizedBox(height: 16),
        buildActionButtons(order, context),
      ],
    ),
  );
}
