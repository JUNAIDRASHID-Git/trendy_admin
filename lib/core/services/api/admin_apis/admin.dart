import "package:admin_pannel/core/const/const.dart";
import "package:admin_pannel/core/services/models/admin_models/admin_model.dart";
import "package:admin_pannel/core/services/models/admin_models/admin_resp.dart";
import "package:admin_pannel/presentation/responsive/desktop_layout.dart";
import "package:admin_pannel/presentation/responsive/mobile_layout.dart";
import "package:admin_pannel/presentation/responsive/responsive.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:http/http.dart" as http;
import "dart:convert";

import "package:universal_html/html.dart" as html; // For jsonDecode

Future<AdminAuthResponse> adminAuthHandler(
  String idToken,
  BuildContext context,
) async {
  try {
    final uri = Uri.parse(googleAdminLoginEndpoint);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'idToken': idToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('Authentication successful: $data');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => ResponsiveLayout(
                mobileLayout: MobileLayout(),
                desktopLayout: DesktopLayout(),
              ),
        ),
      );
      return AdminAuthResponse.fromJson(data);
    } else {
      // Handle non-200 responses (like 403 or 401)
      final error = response.body;
      debugPrint(
        'Authentication failed with status: ${response.statusCode}, error: $error',
      );
      throw Exception(error);
    }
  } catch (e) {
    debugPrint('❌ Error during authentication: $e');
    throw Exception(e.toString());
  }
}

Future<List<Admin>> fetchAdminUsers() async {
  try {
    final uri = Uri.parse(adminsEndpoint);
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json', 'x-api-key': apiKey},
    );

    if (response.statusCode == 200) {
      return jsonDecode(
        response.body,
      ).map<Admin>((json) => Admin.fromJson(json)).toList();
    } else {
      debugPrint(
        'Failed to fetch admin users: ${response.statusCode}, ${response.body}',
      );
      throw Exception('Failed to fetch admin users');
    }
  } catch (e) {
    debugPrint('❌ Error fetching admin users: $e');
    throw Exception('Failed to fetch admin users: $e');
  }
}

// admin logout

Future<void> adminLogout() async {
  try {
    // Firebase sign-out
    await FirebaseAuth.instance.signOut();

    // Clear Google sign-in session on mobile
    if (!kIsWeb) {
      await GoogleSignIn().signOut();
    }

    // Clear cookie on web
    if (kIsWeb) {
      html.document.cookie =
          "jwt=; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT; secure; samesite=strict";
    }

    debugPrint('✅ User logged out successfully');
  } catch (e) {
    debugPrint('❌ Error while logging out: $e');
  }
}

// Approve admin request

Future<void> approveAdmin(String email) async {
  try {
    final uri = Uri.parse(adminApproveAdminEndpoint);
    final response = await http.post(
      uri,
      headers: {"X-api-key": apiKey, "Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print('✅ Admin approved: ${responseData['message']}');
      }
      // Show success to user (toast/snackbar/refresh)
    } else {
      final responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print('❌ Error: ${responseData['error']}');
      }
      // Show error to user
    }
  } catch (e) {
    throw Exception("Failed to approve admin: $e");
  }
}

// reject admin function

Future<void> rejectAdmin(String email) async {
  try {
    final uri = Uri.parse(adminRejectAdminEndpoint);
    final response = await http.post(
      uri,
      headers: {"X-api-key": apiKey, "Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print('✅ Admin Rejected: ${responseData['message']}');
      }
      // Show success to user (toast/snackbar/refresh)
    } else {
      final responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print('❌ Error: ${responseData['error']}');
      }
      // Show error to user
    }
  } catch (e) {
    throw Exception("Failed to approve admin: $e");
  }
}
