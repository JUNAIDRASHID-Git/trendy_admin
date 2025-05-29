// ignore_for_file: deprecated_member_use

import 'package:admin_pannel/core/services/api/admin_apis/admin.dart';
import 'package:admin_pannel/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:universal_html/html.dart' as html;

class AuthAdminPage extends StatelessWidget {
  const AuthAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final isDesktop = screenSize.width > 1200;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 40 : (isTablet ? 32 : 24),
              vertical: 24,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 400 : (isTablet ? 350 : double.infinity),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo/Brand Section
                  Container(
                    width: isDesktop ? 220 : (isTablet ? 70 : 60),
                    height: isDesktop ? 220 : (isTablet ? 70 : 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 100,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/trendy_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: isDesktop ? 40 : (isTablet ? 35 : 30)),

                  // Welcome Text
                  Text(
                    'Admin Portal',
                    style: TextStyle(
                      fontSize: isDesktop ? 32 : (isTablet ? 28 : 24),
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      letterSpacing: -0.5,
                    ),
                  ),

                  SizedBox(height: isDesktop ? 12 : (isTablet ? 10 : 8)),

                  Text(
                    'Sign in to access your dashboard',
                    style: TextStyle(
                      fontSize: isDesktop ? 16 : (isTablet ? 15 : 14),
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: isDesktop ? 50 : (isTablet ? 45 : 40)),

                  // Google Sign-In Button
                  SizedBox(
                    width: double.maxFinite,
                    height: isDesktop ? 56 : (isTablet ? 52 : 48),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          // Trigger Google Sign-In
                          final googleProvider = GoogleAuthProvider();
                          final userCredential = await FirebaseAuth.instance
                              .signInWithPopup(googleProvider);

                          // Get the ID token
                          final idToken =
                              await userCredential.user?.getIdToken();
                          if (idToken == null) {
                            throw Exception("Failed to get ID token.");
                          }

                          // Call your admin authentication handler
                          final response = await adminAuthHandler(
                            idToken,
                            context,
                          );
                          final token = response.token;

                          html.document.cookie =
                              "jwt=$token; path=/; secure; samesite=strict";

                          // Navigate to the dashboard layout
                        } catch (e) {
                          debugPrint("Google Sign-In failed: $e");
                          // Optionally show a snackbar or dialog to the user
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },

                      icon: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(),
                      ),
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/google_logo.png",
                            width: 40,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                              fontSize: isDesktop ? 16 : (isTablet ? 15 : 14),
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.grey[700],
                        elevation: 2,
                        shadowColor: Colors.black.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey[300]!, width: 1),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: isDesktop ? 60 : (isTablet ? 50 : 40)),

                  // Footer Text
                  Text(
                    'By signing in, you agree to our Terms of Service\nand Privacy Policy',
                    style: TextStyle(
                      fontSize: isDesktop ? 12 : (isTablet ? 11 : 10),
                      color: Colors.grey[500],
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
