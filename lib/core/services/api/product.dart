import 'dart:convert';
import 'dart:developer';
import 'package:admin_pannel/core/const/const.dart';
import 'package:admin_pannel/core/services/models/add_product_model.dart';
import 'package:admin_pannel/core/services/models/product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

Future<List<ProductModel>> fetchAllProducts() async {
  final uri = Uri.parse(productEndpoint);

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
      return jsonData.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception("failed to fetch the product");
    }
  } catch (e) {
    log("Error fetching Products: $e");
    rethrow;
  }
}

Future<void> addProduct(AddProductModel product, XFile imageFile) async {
  final uri = Uri.parse(productEndpoint); // Ensure productEndpoint is defined

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
      if (value != null) {
        request.fields[key] = value.toString();
      }
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
