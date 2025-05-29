import 'package:admin_pannel/core/theme/colors.dart';
import 'package:flutter/widgets.dart';

Container headerBar(bool isMobile, double availableWidth) {
  return Container(
    color: AppColors.primary,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ID Column
        SizedBox(
          width: availableWidth * 0.05,
          child: Text(
            'ID',
            style: TextStyle(
              color: AppColors.fontWhite,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(width: availableWidth * 0.01),

        // Image column
        if (!isMobile) ...[
          SizedBox(
            width: availableWidth * 0.1,
            child: Text(
              'Image',
              style: TextStyle(
                color: AppColors.fontWhite,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: availableWidth * 0.02),
        ],

        // Name column
        Expanded(
          flex: isMobile ? 3 : 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Name',
              style: TextStyle(
                color: AppColors.fontWhite,
                fontSize: isMobile ? 12 : 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Categories column
        if (!isMobile || availableWidth > 600)
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: AppColors.fontWhite,
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        // Weight column
        SizedBox(
          width: availableWidth * (isMobile ? 0.15 : 0.1),
          child: Text(
            'Weight',
            style: TextStyle(
              color: AppColors.fontWhite,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(width: availableWidth * 0.01),

        // Sale Price column
        SizedBox(
          width: availableWidth * (isMobile ? 0.2 : 0.12),
          child: Text(
            'Sale Price',
            style: TextStyle(
              color: AppColors.fontWhite,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(width: availableWidth * 0.01),

        // Actions column
        SizedBox(
          width: availableWidth * (isMobile ? 0.2 : 0.15),
          child: Text(
            'Actions',
            style: TextStyle(
              color: AppColors.fontWhite,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
