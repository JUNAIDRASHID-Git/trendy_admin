import 'package:admin_pannel/core/services/models/order/order.dart';
import 'package:admin_pannel/presentation/pages/orders/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showDeleteDialog(OrderModel order, BuildContext mainContext) {
  showDialog(
    context: mainContext,
    builder:
        (context) => AlertDialog(
          title: const Text('Delete Order'),
          content: Text('Are you sure you want to delete order #${order.id}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                mainContext.read<OrderBloc>().add(
                  DeleteOrderEvent(orderID: order.id),
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order deleted successfully')),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        ),
  );
}
