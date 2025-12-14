import 'dart:convert';
import 'package:admin_pannel/core/const/const.dart';
import 'package:admin_pannel/core/services/models/product/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<void> createCategory(
  String ename,
  String arname, [
  dynamic image,
]) async {
  final request = http.MultipartRequest(
    'POST',
    Uri.parse(adminCategoriesEndpoint),
  );

  request.headers['X-API-KEY'] = apiKey;
  request.fields['ename'] = ename;
  request.fields['arname'] = arname;

  if (image != null) {
    if (kIsWeb) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          await image.readAsBytes(),
          filename: image.name,
        ),
      );
    } else {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }
  }

  final res = await request.send();
  if (res.statusCode != 201) {
    throw Exception(await res.stream.bytesToString());
  }
}

Future<CategoryModel> updateCategory(
  int id,
  String ename,
  String arname, [
  dynamic image,
]) async {
  final request = http.MultipartRequest(
    'PUT',
    Uri.parse("$adminCategoriesEndpoint/$id"),
  );

  request.headers['X-API-KEY'] = apiKey;

  if (ename.isNotEmpty) request.fields['ename'] = ename;
  if (arname.isNotEmpty) request.fields['arname'] = arname;

  if (image != null) {
    if (kIsWeb) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          await image.readAsBytes(),
          filename: image.name,
        ),
      );
    } else {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }
  }

  final res = await request.send();
  final body = await res.stream.bytesToString();

  if (res.statusCode == 200) {
    return CategoryModel.fromJson(jsonDecode(body));
  }

  throw Exception(body);
}

// ------------------------- GET ALL -------------------------
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
  final res = await http.delete(
    Uri.parse("$adminCategoriesEndpoint/$id"),
    headers: {'X-API-KEY': apiKey},
  );

  if (res.statusCode != 200) {
    throw Exception(res.body);
  }
}
