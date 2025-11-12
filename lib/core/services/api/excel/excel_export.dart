// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html; // <-- This works only on web
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:admin_pannel/core/const/const.dart';

Future<void> downloadExcelFileWeb() async {
  final url = Uri.parse(adminProductExportExcelEndpoint);

  try {
    final response = await http.get(
      url,
      headers: {
        'X-API-KEY': apiKey,
        'Accept':
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      },
    );

    if (response.statusCode == 200) {
      final blob = html.Blob([response.bodyBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      // ignore: unused_local_variable
      final anchor =
          html.AnchorElement(href: url)
            ..setAttribute("download", "products.xlsx")
            ..click();
      html.Url.revokeObjectUrl(url);

      if (kDebugMode) {
        print('✅ Excel file download triggered in browser');
      }
    } else {
      if (kDebugMode) {
        print('❌ Failed to download file. Status: ${response.statusCode}');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('❌ Error downloading Excel file on web: $e');
    }
  }
}
