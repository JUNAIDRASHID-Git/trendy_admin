import 'dart:io';
import 'package:flutter/foundation.dart'; // kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> formDialog(
  BuildContext context, {
  Function(Map<String, dynamic>)? onSave,
  Map<String, String>? initialValue,
  String title = "New Category",
}) async {
  final enCtrl = TextEditingController(text: initialValue?['en'] ?? '');
  final arCtrl = TextEditingController(text: initialValue?['ar'] ?? '');
  final key = GlobalKey<FormState>();

  File? imageFile; // For mobile
  Uint8List? webImage; // For web

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (kIsWeb) {
        webImage = await picked.readAsBytes();
      } else {
        imageFile = File(picked.path);
      }
    }
  }

  return showDialog(
    context: context,
    builder:
        (_) => StatefulBuilder(
          builder:
              (context, setState) => Dialog(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Form(
                      key: key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...['English', 'Arabic'].map((lang) {
                            final ctrl = lang == 'English' ? enCtrl : arCtrl;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                controller: ctrl,
                                decoration: InputDecoration(
                                  labelText: "Category Name ($lang)",
                                  border: const OutlineInputBorder(),
                                ),
                                validator:
                                    (v) =>
                                        v == null || v.trim().length < 2
                                            ? 'Enter at least 2 chars'
                                            : null,
                              ),
                            );
                          }),
                          GestureDetector(
                            onTap: () async {
                              await pickImage();
                              setState(() {});
                            },
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[50],
                              ),
                              child:
                                  kIsWeb
                                      ? (webImage != null
                                          ? Image.memory(
                                            webImage!,
                                            fit: BoxFit.cover,
                                          )
                                          : _placeholder())
                                      : (imageFile != null
                                          ? Image.file(
                                            imageFile!,
                                            fit: BoxFit.cover,
                                          )
                                          : _placeholder()),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    onSave?.call({
                                      'en': enCtrl.text.trim(),
                                      'ar': arCtrl.text.trim(),
                                      'image': kIsWeb ? webImage : imageFile,
                                    });

                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text("Save"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ),
  );
}

Widget _placeholder() => Center(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Icon(Icons.image, size: 40, color: Colors.grey),
      SizedBox(height: 8),
      Text("Tap to select an image", style: TextStyle(color: Colors.grey)),
    ],
  ),
);
