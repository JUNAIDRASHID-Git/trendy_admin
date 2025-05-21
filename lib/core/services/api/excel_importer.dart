import 'dart:typed_data';
import 'package:admin_pannel/core/const/const.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<void> uploadExcelProducts({
  required String fileName,
  required Uint8List fileBytes,
}) async {
  final uri = Uri.parse(productExcelEndpoint);

  final request =
      http.MultipartRequest("POST", uri)
        ..headers['X-API-KEY'] =
            apiKey // Ensure this is expected by your middleware
        ..files.add(
          http.MultipartFile.fromBytes(
            'file', // 🔥 Must match the backend's form key: c.FormFile("file")
            fileBytes,
            filename: fileName,
            contentType: MediaType(
              'application',
              'vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            ),
          ),
        );

  final response = await request.send();
  final responseBody = await response.stream.bytesToString();

  if (response.statusCode != 200) {
    throw Exception("Upload failed (${response.statusCode}): $responseBody");
  }

  // You can parse the response if needed
  print("✅ Excel uploaded successfully: $responseBody");
}
