import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/pages/admins/admins.dart';
import 'package:admin_pannel/presentation/pages/category/category.dart';
import 'package:admin_pannel/presentation/pages/home/home.dart';
import 'package:admin_pannel/presentation/pages/orders/orders.dart';
import 'package:admin_pannel/presentation/pages/product/pages/products.dart';
import 'package:admin_pannel/presentation/pages/settings/settings.dart';
import 'package:admin_pannel/presentation/pages/users/users.dart';
import 'package:flutter/material.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int _selectedIndex = 0;

  final _pages = [
    const HomePage(),
    OrdersPage(),
    const ProductsPage(),
    const CategoryPage(),
    const UsersPage(),
    const AdminsPage(),
    const SettingsPage(),
  ];

  final _menuItems = const [
    _MenuItem(Icons.dashboard_outlined, 'Dashboard'),
    _MenuItem(Icons.receipt_long_outlined, 'Orders'),
    _MenuItem(Icons.inventory_2_outlined, 'Products'),
    _MenuItem(Icons.category_outlined, 'categories'),
    _MenuItem(Icons.people_outline, 'Users'),
    _MenuItem(Icons.admin_panel_settings_outlined, 'Admins'),
    _MenuItem(Icons.settings_outlined, 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(Icons.menu_rounded, color: Colors.grey[800]),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        title: Text(
          'Trendy Chef',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[900],
            letterSpacing: -0.3,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Colors.grey[200]),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.restaurant_menu,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Trendy Chef',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: 1, color: Colors.grey[200]),

              // Menu Items
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  itemCount: _menuItems.length,
                  itemBuilder:
                      (context, index) => _DrawerTile(
                        icon: _menuItems[index].icon,
                        title: _menuItems[index].title,
                        isSelected: _selectedIndex == index,
                        onTap: () {
                          setState(() => _selectedIndex = index);
                          Navigator.pop(context);
                        },
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;

  const _MenuItem(this.icon, this.title);
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? AppColors.primary.withOpacity(0.08)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isSelected ? AppColors.primary : Colors.grey[600],
                ),
                SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? AppColors.primary : Colors.grey[700],
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
