import 'dart:convert';
import 'dart:developer';
import 'package:admin_pannel/core/const/const.dart';
import 'package:admin_pannel/core/services/models/user_model.dart';
import 'package:http/http.dart' as http;

Future<List<UserModel>> fetchAllUsers() async {
  final uri = Uri.parse(adminUsersEndpoint);

  try {
    final response = await http.get(
      uri,
      headers: {
        "X-API-KEY": apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      log("data fetched");
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  } catch (e) {
    log("Error fetching users: $e");
    rethrow;
  }
}
