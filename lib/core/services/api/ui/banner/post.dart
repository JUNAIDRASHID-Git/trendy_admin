import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:admin_pannel/core/const/const.dart';

Future<void> uploadBannerWeb(
  Uint8List imageBytes,
  String fileName,
  String url,
) async {
  try {
    final uri = Uri.parse("$baseHost/admin/banner/upload");
    final request = http.MultipartRequest('POST', uri);

    request.headers['X-API-KEY'] = apiKey;
    request.files.add(
      http.MultipartFile.fromBytes('image', imageBytes, filename: fileName),
    );

    if (url.isNotEmpty) {
      request.fields['url'] = url;
    }

    final streamedResponse = await request.send();
    final responseBody = await streamedResponse.stream.bytesToString();

    if (streamedResponse.statusCode == 200 ||
        streamedResponse.statusCode == 201) {
      // Success
      log("Banner uploaded successfully: $responseBody");
    } else {
      // Failure
      log("Failed to upload banner. Status: ${streamedResponse.statusCode}");
      log("Response: $responseBody");
      throw Exception(
        'Upload failed with status ${streamedResponse.statusCode}',
      );
    }
  } catch (e) {
    // Network error or other exceptions
    log("Error during banner upload: $e");
    rethrow; // You can also handle or log here instead of rethrowing
  }
}
