import 'package:admin_pannel/core/const/const.dart';
import 'package:http/http.dart' as http;

Future<void> deleteOrder(int id) async {
  final uri = Uri.parse('$baseHost/orders/$id');
  final response = await http.delete(uri, headers: {'X-API-KEY': apiKey});

  if (response.statusCode != 200) {
    throw Exception('Failed to delete category');
  }
}
