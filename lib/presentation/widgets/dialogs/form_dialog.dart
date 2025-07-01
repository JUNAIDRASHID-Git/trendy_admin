import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/widgets/buttons/primary.dart';
import 'package:admin_pannel/presentation/widgets/text/heading_text.dart';
import 'package:flutter/material.dart';

Future<void> formDialog(
  BuildContext context, {
  Function(Map<String, String>)? onSave, // Accept both names in a Map
  Map<String, String>? initialValue,
  String title = "New Category",
}) async {
  final englishCategoryController = TextEditingController(
    text: initialValue?['en'] ?? '',
  );
  final arabicCategoryController = TextEditingController(
    text: initialValue?['ar'] ?? '',
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      double dialogWidth;
      if (screenWidth > 1200) {
        dialogWidth = screenWidth * 0.3;
      } else if (screenWidth > 800) {
        dialogWidth = screenWidth * 0.5;
      } else {
        dialogWidth = screenWidth * 0.9;
      }

      final minWidth = 280.0;
      final maxWidth = dialogWidth.clamp(minWidth, screenWidth * 0.95);
      final maxHeight = screenHeight * 0.8;

      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: maxWidth,
          constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: headingText(title, AppColors.fontBlack)),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.close, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: englishCategoryController,
                      autofocus: true,
                      decoration: _buildInputDecoration(context, "Category Name (English)"),
                      validator: _validateCategoryName,
                      textCapitalization: TextCapitalization.words,
                      maxLength: 50,
                      buildCounter: _buildCounter,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: arabicCategoryController,
                      decoration: _buildInputDecoration(context, "Category Name (Arabic)"),
                      validator: _validateCategoryName,
                      textCapitalization: TextCapitalization.words,
                      maxLength: 50,
                      buildCounter: _buildCounter,
                    ),
                    const SizedBox(height: 24),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 400;
                        final saveButton = primaryBtn(
                          text: "Save",
                          action: () => _handleSave(
                            context,
                            formKey,
                            englishCategoryController,
                            arabicCategoryController,
                            onSave,
                          ),
                        );
                        final cancelButton = TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(padding: const EdgeInsets.all(12)),
                          child: Text("Cancel", style: TextStyle(color: Colors.grey[700])),
                        );
                        return isWide
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [cancelButton, const SizedBox(width: 12), saveButton],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [saveButton, const SizedBox(height: 12), cancelButton],
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

// Extracted input decoration
InputDecoration _buildInputDecoration(BuildContext context, String label) {
  return InputDecoration(
    labelText: label,
    hintText: label,
    filled: true,
    fillColor: Theme.of(context).inputDecorationTheme.fillColor ?? Colors.grey[50],
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 1),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );
}

// Extracted validator
String? _validateCategoryName(String? value) {
  if (value == null || value.trim().isEmpty) return "Category name is required";
  if (value.trim().length < 2) return "Category name must be at least 2 characters";
  return null;
}

// Character counter builder
Widget? _buildCounter(BuildContext context,
    {required int currentLength, required bool isFocused, int? maxLength}) {
  return Text(
    '$currentLength/${maxLength ?? 0}',
    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
  );
}

// Save Handler
void _handleSave(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController english,
  TextEditingController arabic,
  Function(Map<String, String>)? onSave,
) {
  if (formKey.currentState!.validate()) {
    final eName = english.text.trim();
    final aName = arabic.text.trim();
    onSave?.call({'en': eName, 'ar': aName});
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Category "$eName" added successfully'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
        ),
      ),
    );
  }
}
