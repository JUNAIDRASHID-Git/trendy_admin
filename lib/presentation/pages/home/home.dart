import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/pages/admins/admins.dart';
import 'package:admin_pannel/presentation/pages/home/bloc/home_bloc.dart';
import 'package:admin_pannel/presentation/pages/home/bloc/home_state.dart';
import 'package:admin_pannel/presentation/pages/orders/orders.dart';
import 'package:admin_pannel/presentation/pages/product/pages/products.dart';
import 'package:admin_pannel/presentation/pages/users/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1200;
    final isTablet = size.width > 768 && size.width <= 1200;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 3,
              ),
            );
          } else if (state is HomeLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isDesktop ? 32 : 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    _buildHeader(context),
                    const SizedBox(height: 32),

                    // Stats Cards Grid
                    _buildStatsGrid(context, state, isDesktop, isTablet),

                    const SizedBox(height: 24),

                    // Quick Actions Section
                    _buildQuickActions(context, isDesktop),
                  ],
                ),
              ),
            );
          } else if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    "Error: ${state.message}",
                    style: TextStyle(color: Colors.red[700], fontSize: 16),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Dashboard",
          style: TextStyle(
            color: const Color(0xFF1A1D1F),
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Welcome back! Here's what's happening today.",
          style: TextStyle(color: Colors.grey[600], fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(
    BuildContext context,
    HomeLoaded state,
    bool isDesktop,
    bool isTablet,
  ) {
    final crossAxisCount = isDesktop ? 4 : (isTablet ? 2 : 1);

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: isDesktop ? 1.5 : (isTablet ? 1.8 : 2.5),
      children: [
        _buildStatCard(
          context: context,
          title: "Total Users",
          value: state.usersCount.toString(),
          icon: Icons.people_outline,
          color: const Color(0xFF6366F1),
          gradient: LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          ),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UsersPage()),
              ),
        ),
        _buildStatCard(
          context: context,
          title: "Total Admins",
          value: state.adminsCount.toString(),
          icon: Icons.admin_panel_settings_outlined,
          color: const Color(0xFF10B981),
          gradient: LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF059669)],
          ),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminsPage()),
              ),
        ),
        _buildStatCard(
          context: context,
          title: "Total Products",
          value: state.productsCount.toString(),
          icon: Icons.inventory_2_outlined,
          color: const Color(0xFFF59E0B),
          gradient: LinearGradient(
            colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
          ),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductsPage()),
              ),
        ),
        _buildStatCard(
          context: context,
          title: "Total Orders",
          value: state.ordersCount.toString(),
          icon: Icons.shopping_cart_outlined,
          color: const Color(0xFFEC4899),
          gradient: LinearGradient(
            colors: [Color(0xFFEC4899), Color(0xFFF43F5E)],
          ),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrdersPage()),
              ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(icon, color: Colors.white, size: 24),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1D1F),
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1D1F),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildActionButton(
                context,
                "Manage Users",
                Icons.person_add_outlined,
                const Color(0xFF6366F1),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersPage()),
                ),
              ),
              _buildActionButton(
                context,
                "Add Product",
                Icons.add_box_outlined,
                const Color(0xFFF59E0B),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsPage()),
                ),
              ),
              _buildActionButton(
                context,
                "View Orders",
                Icons.receipt_long_outlined,
                const Color(0xFFEC4899),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersPage()),
                ),
              ),
              _buildActionButton(
                context,
                "Manage Admins",
                Icons.shield_outlined,
                const Color(0xFF10B981),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminsPage()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
