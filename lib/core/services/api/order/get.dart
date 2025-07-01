import 'dart:convert';
import 'package:admin_pannel/core/const/const.dart';
import 'package:admin_pannel/core/services/models/order/order.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<OrderModel>> getAllOrders() async {
  final uri = Uri.parse(orderEndpoint); // Put your actual API URL

  try {
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json', 'X-API-KEY': apiKey},
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Orders fetched successfully');
      }
      final List<dynamic> jsonList = jsonDecode(response.body);
      final orders = jsonList.map((json) => OrderModel.fromJson(json)).toList();
      return orders;
    } else {
      if (kDebugMode) {
        print(
          'Failed to fetch orders: ${response.statusCode} - ${response.body}',
        );
      }
      throw Exception('Failed to fetch orders: ${response.statusCode}');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Exception while fetching orders: $e');
    }
    throw Exception('Failed to fetch orders');
  }
}
