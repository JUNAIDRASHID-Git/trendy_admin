import 'dart:convert';
import 'package:admin_pannel/core/const/const.dart';
import 'package:http/http.dart' as http;

Future<void> editOrderShippingCost(int orderID, double shippingCost) async {
  final uri = Uri.parse('$baseHost/orders/$orderID/shipping-cost');

  try {
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json', 'X-API-KEY': apiKey},
      body: jsonEncode({"shipping_cost": shippingCost}),
    );

    if (response.statusCode == 200) {
      // Success
      print("✅ Shipping cost updated successfully");
    } else {
      // Error
      print("❌ Failed to update shipping cost: ${response.body}");
      throw Exception("Failed with status: ${response.statusCode}");
    }
  } catch (e) {
    print("⚠️ Error updating shipping cost: $e");
    rethrow;
  }
}
