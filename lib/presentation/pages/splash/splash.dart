import 'package:admin_pannel/presentation/pages/auth/auth_admin.dart';
import 'package:admin_pannel/presentation/responsive/desktop_layout.dart';
import 'package:admin_pannel/presentation/responsive/mobile_layout.dart';
import 'package:admin_pannel/presentation/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  /// Check if a "jwt" cookie is present and non-empty.
  bool _hasJwtCookie() {
    final cookies = html.document.cookie ?? '';
    for (final cookie in cookies.split(';')) {
      final parts = cookie.split('=');
      if (parts.length == 2 && parts[0].trim() == 'jwt' && parts[1].trim().isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // After first frame, wait briefly, then route.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Optional: add a small delay to show the splash indicator
      await Future.delayed(const Duration(milliseconds: 500));

      final hasToken = _hasJwtCookie();
      final nextPage = hasToken
          ? const ResponsiveLayout(
              mobileLayout: MobileLayout(),
              desktopLayout: DesktopLayout(),
            )
          : const AuthAdminPage();

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => nextPage),
        );
      }
    });

    return const Scaffold(
      backgroundColor: Color(0xFFFFFDE9),
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xFF02542D),
          strokeWidth: 3,
        ),
      ),
    );
  }
}
