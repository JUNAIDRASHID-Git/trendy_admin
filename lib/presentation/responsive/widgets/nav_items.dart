import 'package:flutter/material.dart';

Widget buildNavItem({
  required int index,
  required IconData icon,
  required IconData activeIcon,
  required String title,
  required int selectedIndex,
  required bool isExpanded,
  required Function()? onTap,
}) {
  final isSelected = selectedIndex == index;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: isExpanded ? 12 : 8, vertical: 4),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isExpanded ? 16 : 12,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color:
                isSelected
                    ? const Color(0xFF6366F1).withOpacity(0.1)
                    : Colors.transparent,
            border: Border.all(
              color:
                  isSelected
                      ? const Color(0xFF6366F1).withOpacity(0.3)
                      : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color:
                    isSelected
                        ? const Color(0xFF6366F1)
                        : const Color(0xFF6B7280),
                size: 22,
              ),
              if (isExpanded) ...[
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color:
                          isSelected
                              ? const Color(0xFF1A1D1F)
                              : const Color(0xFF6B7280),
                      fontSize: 15,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}
