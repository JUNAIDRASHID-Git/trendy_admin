import 'dart:convert';
import 'package:admin_pannel/core/const/const.dart';
import 'package:admin_pannel/core/services/models/product/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// For jsonEncode

Future<void> createCategory(String ename, String arname) async {
  final uri = Uri.parse(adminCategoriesEndpoint);
  try {
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json', 'X-API-KEY': apiKey},
      body: jsonEncode({
        "ename": ename,
        "arname": arname,
      }), // Fix: encode to JSON
    );

    if (response.statusCode == 201) {
      // Successfully created category
      if (kDebugMode) {
        print('Category created: ${response.body}');
      }
    } else {
      // Handle error from API
      if (kDebugMode) {
        print(
          'Failed to create category: ${response.statusCode} - ${response.body}',
        );
      }
      throw Exception('Failed to create category: ${response.statusCode}');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Exception while creating category: $e');
    }
    throw Exception('Failed to create category');
  }
}

Future<CategoryModel> updateCategory(
  int id,
  String ename,
  String arname,
) async {
  final body = json.encode({"ename": ename, "arname": arname});

  try {
    final uri = Uri.parse("$adminCategoriesEndpoint/$id");

    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json', 'X-API-KEY': apiKey},
      body: body,
    );

    if (response.statusCode == 200) {
      return CategoryModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update category');
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<List<CategoryModel>> getAllCategories() async {
  final uri = Uri.parse(adminCategoriesEndpoint);

  final response = await http.get(
    uri,
    headers: {'Content-Type': 'application/json', "X-API-KEY": apiKey},
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  } else {
    throw Exception('Failed to load categories');
  }
}

Future<void> deleteCategory(int id) async {
  final uri = Uri.parse('$adminCategoriesEndpoint/$id');
  final response = await http.delete(uri, headers: {'X-API-KEY': apiKey});

  if (response.statusCode != 200) {
    throw Exception('Failed to delete category');
  }
}
