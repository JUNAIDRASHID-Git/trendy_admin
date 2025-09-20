import 'package:admin_pannel/core/services/models/order/order.dart';
import 'package:admin_pannel/presentation/pages/orders/bloc/order_bloc.dart';
import 'package:admin_pannel/presentation/pages/orders/widgets/builders/action_buttons.dart';
import 'package:admin_pannel/presentation/pages/orders/widgets/builders/info_card.dart';
import 'package:admin_pannel/presentation/pages/orders/widgets/builders/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildOrderDetails(OrderModel order, BuildContext context) {
  final TextEditingController shippingController = TextEditingController(
    text: order.shippingCost.toStringAsFixed(2),
  );

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
            if (order.status == "pending") ...[
              SizedBox(
                width: 120,
                child: TextFormField(
                  controller: shippingController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: "Shipping",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final value = double.tryParse(shippingController.text);
                  if (value == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Enter valid shipping cost"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  context.read<OrderBloc>().add(
                    EditOrderShippingCostEvent(
                      orderID: order.id,
                      shippingCost: value,
                    ),
                  );

                  // 👉 Trigger Bloc or API call to update shipping cost
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Shipping updated to \$${value.toStringAsFixed(2)}",
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                child: const Text("Apply"),
              ),
            ] else ...[
              Text(
                "Shipping: \$${order.shippingCost.toStringAsFixed(2)}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],

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
