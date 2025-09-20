import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:admin_pannel/core/const/const.dart';

Future<void> deleteBanner({required int bannerID}) async {
  final uri = Uri.parse("$baseHost/admin/banner/$bannerID");

  try {
    final response = await http.delete(
      uri,
      headers: {'Content-Type': 'application/json', 'X-API-KEY': apiKey},
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print('Banner deleted successfully: $decoded');
    } else {
      throw Exception(
        'Failed to delete banner. Status: ${response.statusCode}\nBody: ${response.body}',
      );
    }
  } catch (e) {
    print('Error deleting banner: $e');
    rethrow; // Optional: let higher-level handlers catch it
  }
}
