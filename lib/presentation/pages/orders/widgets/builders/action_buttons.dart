import 'package:admin_pannel/core/services/models/order/order.dart';
import 'package:admin_pannel/presentation/pages/orders/widgets/builders/action_button.dart';
import 'package:admin_pannel/presentation/pages/orders/widgets/dialogs/delete.dart';
import 'package:admin_pannel/presentation/pages/orders/widgets/dialogs/status.dart';
import 'package:flutter/material.dart';

Widget buildActionButtons(OrderModel order, BuildContext context) {
  return Row(
    children: [
      buildActionButton(
        'Update Status',
        Icons.update,
        Colors.green,
        () => showStatusDialog(order, context),
      ),
      const SizedBox(width: 8),
      buildActionButton('Delete', Icons.delete, Colors.red, () {
        showDeleteDialog(order, context);
      }),
    ],
  );
}
