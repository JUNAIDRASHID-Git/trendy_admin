import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:admin_pannel/core/const/const.dart';

Future<void> editOrderStatus(int orderID, String orderStatus) async {
  final uri = Uri.parse('$baseHost/orders/$orderID/status');

  try {
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json', 'X-API-KEY': apiKey},
      body: jsonEncode({"status": orderStatus}),
    );

    if (response.statusCode != 200) {
      final errorMsg = jsonDecode(response.body)['message'] ?? 'Unknown error';
      throw Exception('Failed to update order status: $errorMsg');
    }
  } catch (e) {
    throw Exception('Error updating order status: $e');
  }
}

Future<void> editOrderPaymentStatus(int orderID, String paymentStatus) async {
  final uri = Uri.parse('$baseHost/orders/$orderID/payment-status');

  try {
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json', 'X-API-KEY': apiKey},
      body: jsonEncode({"payment_status": paymentStatus}),
    );

    if (response.statusCode != 200) {
      final errorMsg = jsonDecode(response.body)['message'] ?? 'Unknown error';
      throw Exception('Failed to update payment status: $errorMsg');
    }
  } catch (e) {
    throw Exception('Error updating payment status: $e');
  }
}
