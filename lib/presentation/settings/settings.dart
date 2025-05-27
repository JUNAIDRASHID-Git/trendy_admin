import 'package:admin_pannel/core/services/api/admin_apis/admin.dart';
import 'package:admin_pannel/presentation/auth/auth_admin.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Add your settings functionality here
          adminLogout();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Settings button pressed')),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AuthAdminPage()),
            (route) => false,
          );
        },
        child: const Text('Logout'),
      ),
    );
  }
}
