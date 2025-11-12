import 'dart:convert';
import 'dart:developer';
import 'package:admin_pannel/core/const/const.dart';
import 'package:admin_pannel/core/services/models/banner/banner.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<BannerModel>> getBanners() async {
  final uri = Uri.parse("$baseHost/admin/banner/");

  try {
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json', 'X-API-KEY': apiKey},
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      log('Banners fetched: $decoded');

      if (decoded is List) {
        return decoded.map((json) => BannerModel.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception(
        'Failed to fetch banners. Status: ${response.statusCode}',
      );
    }
  } catch (e) {
    if (kDebugMode) {
      print('getBanners error: $e');
    }
    return [];
  }
}
