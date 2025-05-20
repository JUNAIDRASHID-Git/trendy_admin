import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/admins/admins.dart';
import 'package:admin_pannel/presentation/home/home.dart';
import 'package:admin_pannel/presentation/orders/orders.dart';
import 'package:admin_pannel/presentation/product/pages/add_product.dart';
import 'package:admin_pannel/presentation/product/pages/products.dart';
import 'package:admin_pannel/presentation/settings/settings.dart';
import 'package:admin_pannel/presentation/users/users.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    HomePage(),
    OrdersPage(),
    ProductsPage(),
    UsersPage(),
    AdminsPage(),
    SettingsPage(),
    AddProductPage(),
  ];

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String title,
  }) {
    final isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? primaryColor : Colors.transparent,
        ),
        child: ListTile(
          leading: Icon(icon, color: isSelected ? fontWhite : fontColor),
          title: Text(
            title,
            style: TextStyle(color: isSelected ? fontWhite : fontColor),
          ),
          onTap: () {
            setState(() => _selectedIndex = index);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 190,
            color: const Color.fromARGB(255, 220, 220, 220),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: 20),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset("assets/images/trendy_logo.png"),
                ),
                SizedBox(height: 20),
                _buildNavItem(
                  index: 0,
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                ),
                _buildNavItem(
                  index: 1,
                  icon: Icons.receipt_long,
                  title: 'Orders',
                ),
                _buildNavItem(
                  index: 2,
                  icon: Icons.shopping_bag,
                  title: 'Products',
                ),
                _buildNavItem(index: 3, icon: Icons.people, title: 'Users'),
                _buildNavItem(
                  index: 4,
                  icon: Icons.admin_panel_settings,
                  title: 'Admins',
                ),
                _buildNavItem(
                  index: 5,
                  icon: Icons.settings,
                  title: 'Settings',
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
