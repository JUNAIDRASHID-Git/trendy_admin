import 'package:admin_pannel/presentation/pages/admins/admins.dart';
import 'package:admin_pannel/presentation/pages/home/home.dart';
import 'package:admin_pannel/presentation/pages/orders/orders.dart';
import 'package:admin_pannel/presentation/pages/category/category.dart';
import 'package:admin_pannel/presentation/pages/product/pages/products.dart';
import 'package:admin_pannel/presentation/pages/settings/settings.dart';
import 'package:admin_pannel/presentation/pages/ui/pages/ui.dart';
import 'package:admin_pannel/presentation/pages/users/users.dart';
import 'package:admin_pannel/presentation/responsive/widgets/nav_items.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  int _selectedIndex = 0;
  bool _isExpanded = true;

  final List<Widget> _pages = [
    HomePage(),
    UiPage(),
    OrdersPage(),
    ProductsPage(),
    CategoryPage(),
    UsersPage(),
    AdminsPage(),
    SettingsPage(),
  ];

  final List<NavItem> _navItems = [
    NavItem(
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      title: 'Dashboard',
    ),
    NavItem(icon: Icons.pages_outlined, activeIcon: Icons.pages, title: 'UI'),
    NavItem(
      icon: Icons.receipt_long_outlined,
      activeIcon: Icons.receipt_long,
      title: 'Orders',
    ),
    NavItem(
      icon: Icons.shopping_bag_outlined,
      activeIcon: Icons.shopping_bag,
      title: 'Products',
    ),
    NavItem(
      icon: Icons.category_outlined,
      activeIcon: Icons.category,
      title: 'Categories',
    ),
    NavItem(
      icon: Icons.people_outline,
      activeIcon: Icons.people,
      title: 'Users',
    ),
    NavItem(
      icon: Icons.admin_panel_settings_outlined,
      activeIcon: Icons.admin_panel_settings,
      title: 'Admins',
    ),
    NavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      title: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final sidebarWidth = _isExpanded ? 260.0 : 80.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Row(
        children: [
          // Modern Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: sidebarWidth,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: Color(0xFFE5E7EB), width: 1),
              ),
            ),
            child: Column(
              children: [
                // User Section
                Container(
                  padding: EdgeInsets.all(_isExpanded ? 16 : 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      if (_isExpanded) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Admin User",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A1D1F),
                                ),
                              ),
                              Text(
                                "admin@panel.com",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.logout_outlined,
                            size: 20,
                            color: Color(0xFF6B7280),
                          ),
                          onPressed: () {
                            // Handle logout
                          },
                        ),
                      ],
                    ],
                  ),
                ),

                // Toggle Button
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _isExpanded ? 12 : 8,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() => _isExpanded = !_isExpanded);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _isExpanded
                                  ? Icons.chevron_left
                                  : Icons.chevron_right,
                              color: const Color(0xFF6B7280),
                              size: 20,
                            ),
                            if (_isExpanded) ...[
                              const SizedBox(width: 8),
                              const Text(
                                "Collapse",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Navigation Items
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _navItems.length,
                    itemBuilder: (context, index) {
                      final item = _navItems[index];
                      return buildNavItem(
                        index: index,
                        icon: item.icon,
                        activeIcon: item.activeIcon,
                        title: item.title,
                        selectedIndex: _selectedIndex,
                        isExpanded: _isExpanded,
                        onTap: () {
                          setState(() => _selectedIndex = index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String title;

  NavItem({required this.icon, required this.activeIcon, required this.title});
}
