import 'dart:convert';
import 'dart:developer';
import 'package:admin_pannel/core/const/const.dart';
import 'package:admin_pannel/core/services/models/product/add_product_model.dart';
import 'package:admin_pannel/core/services/models/product/editproduct_model.dart';
import 'package:admin_pannel/core/services/models/product/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

Future<List<ProductModel>> fetchAllProducts() async {
  final uri = Uri.parse(adminProductsEndpoint);

  try {
    final response = await http.get(
      uri,
      headers: {
        "X-API-KEY": apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      log("Products data fetched");
      final List<dynamic> jsonData = json.decode(response.body);
      final products = jsonData.map((e) => ProductModel.fromJson(e)).toList();
      return products.toList();
    } else {
      throw Exception("failed to fetch the product");
    }
  } catch (e) {
    log("Error fetching Products: $e");
    rethrow;
  }
}

Future<void> addProduct(AddProductModel product, XFile imageFile) async {
  final uri = Uri.parse(adminProductsEndpoint); // Ensure adminProductsEndpoint is defined

  try {
    final request = http.MultipartRequest('POST', uri)
      ..headers['X-API-KEY'] = apiKey;

    // Add image file
    final imageStream = http.MultipartFile.fromBytes(
      'image', // Adjust this field name if your backend expects a different name
      await imageFile.readAsBytes(),
      filename: path.basename(imageFile.path),
    );
    request.files.add(imageStream);

    // Add the rest of the fields as form fields
    final fields = product.toJson();
    fields.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    final response = await request.send();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      log("✅ Product created successfully");
    } else {
      final respStr = await response.stream.bytesToString();
      log("❌ Failed to create product: ${response.statusCode} $respStr");
      throw Exception('Failed to create product');
    }
  } catch (e) {
    log("🚨 Exception while adding product: $e");
    rethrow;
  }
}

Future<void> updateProduct(
  int id,
  EditProductModel product, {
  XFile? imageFile,
}) async {
  final uri = Uri.parse("$adminProductsEndpoint/$id");

  try {
    final request = http.MultipartRequest('PUT', uri)
      ..headers['X-API-KEY'] = apiKey;

    // Only print imageFile if it's not null
    if (imageFile != null) {
      print("$imageFile image file");

      // Add image if provided
      final imageStream = http.MultipartFile.fromBytes(
        'image',
        await imageFile.readAsBytes(),
        filename: path.basename(imageFile.path),
      );
      request.files.add(imageStream);
    } else {
      print("No image file provided, skipping image upload");
    }

    // Convert the product fields to a map of form fields
    final fields = product.toJson();
    print(fields);
    fields.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    final response = await request.send();

    if (response.statusCode == 200) {
      log("✅ Product updated successfully");
    } else {
      final respStr = await response.stream.bytesToString();
      log("❌ Failed to update product: ${response.statusCode} $respStr");
      throw Exception('Failed to update product');
    }
  } catch (e) {
    log("🚨 Exception while updating product: $e");
    rethrow;
  }
}

Future<void> deleteProduct(int id) async {
  final uri = Uri.parse('$adminProductsEndpoint/$id');

  try {
    final response = await http.delete(
      uri,
      headers: {
        "X-API-KEY": apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      log("✅ Product deleted successfully");
    } else {
      log("❌ Failed to delete product: ${response.statusCode}");
      throw Exception('Failed to delete product');
    }
  } catch (e) {
    log("🚨 Exception while deleting product: $e");
    rethrow;
  }
}
