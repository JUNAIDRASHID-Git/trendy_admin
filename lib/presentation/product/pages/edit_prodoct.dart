// ignore_for_file: use_build_context_synchronously

import 'dart:io' show File;

import 'package:admin_pannel/core/services/models/editproduct_model.dart';
import 'package:admin_pannel/core/services/models/product_model.dart';
import 'package:admin_pannel/presentation/product/widgets/textfields/build_text_field.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/product/bloc/product_bloc.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel product;
  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final nameENController = TextEditingController();
  final nameARController = TextEditingController();
  final descriptionENController = TextEditingController();
  final descriptionARController = TextEditingController();
  final salePriceController = TextEditingController();
  final regularPriceController = TextEditingController();
  final baseCostController = TextEditingController();
  final weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameENController.text = widget.product.eName;
    nameARController.text = widget.product.arName!;
    descriptionENController.text = widget.product.eDescription!;
    descriptionARController.text = widget.product.arDescription!;
    salePriceController.text = widget.product.salePrice.toString();
    regularPriceController.text = widget.product.regularPrice.toString();
    baseCostController.text = widget.product.baseCost.toString();
    weightController.text = widget.product.weight.toString();
    selectedCategories.addAll(widget.product.categories);
  }

  // Categories
  final List<String> availableCategories = [
    'Snacks',
    'Drinks',
    'Groceries',
    'Electronics',
  ];
  final Set<String> selectedCategories = {};

  XFile? selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final bytes = await image.readAsBytes();
    final decodedImage = await decodeImageFromList(bytes);
    if (decodedImage.width != 1200 || decodedImage.height != 1200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image must be 1200x1200 pixels'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      setState(() {
        selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Update Product",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 700;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Flex(
                    direction: isWide ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: isWide ? 1 : 0,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade200),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Product Image",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Center(
                                  child: GestureDetector(
                                    onTap: pickImage,
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child:
                                          selectedImage != null
                                              ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child:
                                                    kIsWeb
                                                        ? Image.network(
                                                          selectedImage!.path,
                                                          fit: BoxFit.cover,
                                                        )
                                                        : Image.file(
                                                          File(
                                                            selectedImage!.path,
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                              )
                                              : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .add_photo_alternate_outlined,
                                                    size: 48,
                                                    color: Colors.grey[400],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    "Upload Image (1200x1200)",
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                    ),
                                  ),
                                ),
                                if (isWide)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 24),
                                      const Text(
                                        "Categories",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children:
                                            availableCategories.map((category) {
                                              return FilterChip(
                                                label: Text(category),
                                                selected: selectedCategories
                                                    .contains(category),
                                                backgroundColor:
                                                    Colors.grey[50],
                                                selectedColor: Colors.blue[50],
                                                checkmarkColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  side: BorderSide(
                                                    color:
                                                        selectedCategories
                                                                .contains(
                                                                  category,
                                                                )
                                                            ? Colors.blue
                                                            : Colors
                                                                .grey
                                                                .shade300,
                                                  ),
                                                ),
                                                onSelected: (bool selected) {
                                                  setState(() {
                                                    if (selected) {
                                                      selectedCategories.add(
                                                        category,
                                                      );
                                                    } else {
                                                      selectedCategories.remove(
                                                        category,
                                                      );
                                                    }
                                                  });
                                                },
                                              );
                                            }).toList(),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: isWide ? 24 : 0, height: isWide ? 0 : 24),
                      Expanded(
                        flex: isWide ? 2 : 0,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade200),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Product Details",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                buildTextField(
                                  controller: nameENController,
                                  label: 'Product Name (EN)',
                                  isRequired: true,
                                ),
                                buildTextField(
                                  controller: nameARController,
                                  label: 'Product Name (AR)',
                                  isRequired: true,
                                ),
                                buildTextField(
                                  controller: descriptionENController,
                                  label: 'Description (EN)',
                                  maxLines: 3,
                                ),
                                buildTextField(
                                  controller: descriptionARController,
                                  label: 'Description (AR)',
                                  maxLines: 3,
                                ),
                                const SizedBox(height: 24),
                                const Text(
                                  "Pricing",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: buildTextField(
                                        controller: salePriceController,
                                        label: 'Sale Price (Required)',
                                        keyboardType:
                                            const TextInputType.numberWithOptions(
                                              decimal: true,
                                            ),
                                        prefixIcon: const Icon(
                                          Icons.attach_money,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: buildTextField(
                                        controller: regularPriceController,
                                        label: 'Regular Price',
                                        keyboardType:
                                            const TextInputType.numberWithOptions(
                                              decimal: true,
                                            ),
                                        prefixIcon: const Icon(
                                          Icons.attach_money,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: buildTextField(
                                        controller: baseCostController,
                                        label: 'Base Cost',
                                        keyboardType:
                                            const TextInputType.numberWithOptions(
                                              decimal: true,
                                            ),
                                        prefixIcon: const Icon(
                                          Icons.attach_money,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: buildTextField(
                                        controller: weightController,
                                        label: 'Weight (kg)',
                                        keyboardType:
                                            const TextInputType.numberWithOptions(
                                              decimal: true,
                                            ),
                                        prefixIcon: const Icon(
                                          Icons.scale,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (!isWide)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 24),
                                      const Text(
                                        "Categories",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children:
                                            availableCategories.map((category) {
                                              return FilterChip(
                                                label: Text(category),
                                                selected: selectedCategories
                                                    .contains(category),
                                                backgroundColor:
                                                    Colors.grey[50],
                                                selectedColor: Colors.blue[50],
                                                checkmarkColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  side: BorderSide(
                                                    color:
                                                        selectedCategories
                                                                .contains(
                                                                  category,
                                                                )
                                                            ? Colors.blue
                                                            : Colors
                                                                .grey
                                                                .shade300,
                                                  ),
                                                ),
                                                onSelected: (bool selected) {
                                                  setState(() {
                                                    if (selected) {
                                                      selectedCategories.add(
                                                        category,
                                                      );
                                                    } else {
                                                      selectedCategories.remove(
                                                        category,
                                                      );
                                                    }
                                                  });
                                                },
                                              );
                                            }).toList(),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 32),
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<ProductBloc>().add(
                                          ProductUpdateEvent(
                                            int.parse(
                                              widget.product.id.toString(),
                                            ),
                                            EditProductModel(
                                              eName: nameENController.text,
                                              arName: nameARController.text,
                                              eDescription:
                                                  descriptionENController.text,
                                              arDescription:
                                                  descriptionARController.text,
                                              salePrice: double.parse(
                                                salePriceController.text,
                                              ),
                                              regularPrice: double.parse(
                                                regularPriceController.text,
                                              ),
                                              baseCost: double.parse(
                                                baseCostController.text,
                                              ),
                                              weight: double.parse(
                                                weightController.text,
                                              ),
                                              categories:
                                                  selectedCategories.toList(),
                                              createdAt:
                                                  widget.product.createdAt,
                                              updatedAt: DateTime.now(),
                                            ),
                                            selectedImage,
                                          ),
                                        );

                                        Navigator.pop(context);

                                        // Submit logic here
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Product saved successfully!',
                                            ),
                                            backgroundColor: AppColors.primary,
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      "Save Product",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
