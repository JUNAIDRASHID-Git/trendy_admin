import 'dart:convert';
import 'package:admin_pannel/core/const/const.dart';
import 'package:admin_pannel/core/services/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<void> createCategory(CategoryModel category) async {
  final response = await http.post(
    Uri.parse('https://api.example.com/categories'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(category.toJson()),
  );

  if (response.statusCode == 201) {
    // Successfully created category
    if (kDebugMode) {
      print('Category created: ${response.body}');
    }
  } else {
    throw Exception('Failed to create category');
  }
}

Future<CategoryModel> updateCategory(CategoryModel category) async {
  final response = await http.put(
    Uri.parse('https://api.example.com/categories/${category.id}'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(category.toJson()),
  );

  if (response.statusCode == 200) {
    return CategoryModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to update category');
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
  final response = await http.delete(
    uri,
    headers: {'X-API-KEY': apiKey},
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to delete category');
  }
}
