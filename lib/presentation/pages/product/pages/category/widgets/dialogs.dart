import 'package:flutter/material.dart';

void showDeleteDialog(BuildContext context, dynamic category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Delete Category",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: Text(
            "Are you sure you want to delete '${category.name}'? This action cannot be undone.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Implement delete logic here
                print("Delete category ${category.id}");
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }