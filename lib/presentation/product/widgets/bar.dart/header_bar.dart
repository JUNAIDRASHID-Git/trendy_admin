import 'package:admin_pannel/core/theme/colors.dart';
import 'package:flutter/widgets.dart';

Container headerBar(bool isMobile, double availableWidth) {
  return Container(
    color: primaryColor,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    child: Row(
      children: [
        // No column
        SizedBox(
          width: isMobile ? availableWidth * 0.08 : availableWidth * 0.05,
          child: Text(
            'No.',
            style: TextStyle(
              color: fontWhite,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Image column
        SizedBox(
          width: isMobile ? availableWidth * 0.15 : availableWidth * 0.1,
          child: Text(
            'Image',
            style: TextStyle(
              color: fontWhite,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Name column
        SizedBox(
          width: isMobile ? availableWidth * 0.25 : availableWidth * 0.2,
          child: Text(
            'Name',
            style: TextStyle(
              color: fontWhite,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Categories column
        SizedBox(
          width: isMobile ? availableWidth * 0.25 : availableWidth * 0.3,
          child: Text(
            'Categories',
            style: TextStyle(
              color: fontWhite,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Weight column
        SizedBox(
          width: isMobile ? availableWidth * 0.12 : availableWidth * 0.15,
          child: Text(
            'Weight',
            style: TextStyle(
              color: fontWhite,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Actions column
        Expanded(
          child: Text(
            'Actions',
            style: TextStyle(
              color: fontWhite,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
