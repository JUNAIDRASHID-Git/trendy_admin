import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/pages/admins/admins.dart';
import 'package:admin_pannel/presentation/pages/home/home.dart';
import 'package:admin_pannel/presentation/pages/orders/orders.dart';
import 'package:admin_pannel/presentation/pages/product/pages/products.dart';
import 'package:admin_pannel/presentation/pages/settings/settings.dart';
import 'package:admin_pannel/presentation/pages/ui/pages/ui.dart';
import 'package:admin_pannel/presentation/pages/users/users.dart';
import 'package:admin_pannel/presentation/widgets/icons/main_logo.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    UiPage(),
    OrdersPage(),
    ProductsPage(),
    UsersPage(),
    AdminsPage(),
    SettingsPage(),
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
          color: isSelected ? AppColors.secondary : Colors.transparent,
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isSelected ? AppColors.fontBlack : AppColors.fontWhite,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isSelected ? AppColors.fontBlack : AppColors.fontWhite,
            ),
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
            color: AppColors.primary,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: 20),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: MainLogo(imagePath: "assets/images/trendy_logo.png"),
                ),
                SizedBox(height: 20),
                _buildNavItem(
                  index: 0,
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                ),
                _buildNavItem(index: 1, icon: Icons.pages, title: "UI"),
                _buildNavItem(
                  index: 2,
                  icon: Icons.receipt_long,
                  title: 'Orders',
                ),
                _buildNavItem(
                  index: 3,
                  icon: Icons.shopping_bag,
                  title: 'Products',
                ),
                _buildNavItem(index: 4, icon: Icons.people, title: 'Users'),
                _buildNavItem(
                  index: 5,
                  icon: Icons.admin_panel_settings,
                  title: 'Admins',
                ),
                _buildNavItem(
                  index: 6,
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
