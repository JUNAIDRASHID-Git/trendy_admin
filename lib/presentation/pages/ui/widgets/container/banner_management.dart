import 'package:admin_pannel/presentation/pages/ui/bloc/ui_bloc.dart';
import 'package:flutter/material.dart';
import 'package:admin_pannel/core/services/models/banner/banner.dart';
import 'package:admin_pannel/presentation/pages/ui/widgets/banner/upload_banner.dart';
import 'package:admin_pannel/presentation/pages/ui/widgets/container/banner_list.dart';
import 'package:admin_pannel/core/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerManagement extends StatefulWidget {
  final List<BannerModel> banners;
  const BannerManagement({super.key, required this.banners});

  @override
  State<BannerManagement> createState() => _BannerManagementState();
}

class _BannerManagementState extends State<BannerManagement> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onTabChanged(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildTabBar(),
          const SizedBox(height: 8),
          Expanded(child: _buildPageView(context)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        "Banner Management",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildTabButton("All Banners", 0),
          const SizedBox(width: 8),
          _buildTabButton("Upload", 1),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: TextButton(
        onPressed: () => _onTabChanged(index),
        style: TextButton.styleFrom(
          backgroundColor:
              isSelected
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.grey[200],
          foregroundColor: isSelected ? AppColors.primary : Colors.black87,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(label, style: const TextStyle(fontSize: 14)),
      ),
    );
  }

  Widget _buildPageView(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      children: [
        widget.banners.isEmpty
            ? _buildEmptyState()
            : Padding(
              padding: const EdgeInsets.all(16),
              child: bannerListContainer(widget.banners),
            ),
        const Padding(padding: EdgeInsets.all(16), child: BannerUploader()),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            size: 48,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            "No Banners Available",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            "Tap 'Upload' to add your first banner",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _onTabChanged(1),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Upload Banner"),
          ),
        ],
      ),
    );
  }
}
