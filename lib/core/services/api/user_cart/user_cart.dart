import 'dart:convert';
import 'package:admin_pannel/core/const/const.dart';
import 'package:admin_pannel/core/services/models/cart/cart.dart';
import 'package:http/http.dart' as http;

Future<List<CartItemModel>> fetchCartItems(String userid) async {
  final uri = Uri.parse("$userCartEndpoint$userid");

  final response = await http.get(
    uri,
    headers: {
        "X-API-KEY": apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
  );
  if (response.statusCode == 200) {
    final List jsonData = json.decode(response.body);
    return jsonData.map((e) => CartItemModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load cart items');
  }
}
