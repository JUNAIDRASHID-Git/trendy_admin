import 'package:admin_pannel/core/services/models/order/order.dart';
import 'package:admin_pannel/presentation/pages/orders/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showStatusDialog(OrderModel order, BuildContext mainContext) {
  // ✅ Define valid statuses
  const validOrderStatuses = [
    'pending',
    'confirmed',
    'ready_to_ship',
    'shipped',
    'delivered',
    'returned',
    'cancelled',
  ];

  const validPaymentStatuses = [
    'pending',
    'paid',
    'failed',
    'refunded',
  ];

  // ✅ Validate and assign selected status values
  String selectedOrderStatus = validOrderStatuses.contains(order.status)
      ? order.status
      : 'pending';

  String selectedPaymentStatus = validPaymentStatuses.contains(order.paymentStatus)
      ? order.paymentStatus
      : 'pending';

  showDialog(
    context: mainContext,
    builder: (context) => AlertDialog(
      title: Text('Update Order - #${order.id}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: selectedOrderStatus,
            decoration: const InputDecoration(labelText: 'Order Status'),
            onChanged: (value) {
              if (value != null) selectedOrderStatus = value;
            },
            items: validOrderStatuses
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(_capitalize(status.replaceAll('_', ' '))),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedPaymentStatus,
            decoration: const InputDecoration(labelText: 'Payment Status'),
            onChanged: (value) {
              if (value != null) selectedPaymentStatus = value;
            },
            items: validPaymentStatuses
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(_capitalize(status)),
                    ))
                .toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Dispatch update events
            mainContext.read<OrderBloc>().add(
                  EditOrderStatusEvent(
                    orderID: order.id,
                    status: selectedOrderStatus,
                  ),
                );

            mainContext.read<OrderBloc>().add(
                  EditOrderPaymentStatusEvent(
                    orderID: order.id,
                    paymentStatus: selectedPaymentStatus,
                  ),
                );

            Navigator.pop(context);

            // Show confirmation
            ScaffoldMessenger.of(mainContext).showSnackBar(
              SnackBar(
                content: Text(
                  'Updated:\nOrder Status → $selectedOrderStatus\nPayment Status → $selectedPaymentStatus',
                ),
              ),
            );
          },
          child: const Text('Update'),
        ),
      ],
    ),
  );
}

// ✅ Utility function to capitalize status labels
String _capitalize(String text) {
  return text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
}
