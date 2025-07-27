import 'dart:io' show File;
import 'package:admin_pannel/core/services/api/category/category.dart';
import 'package:admin_pannel/core/services/models/product/add_product_model.dart';
import 'package:admin_pannel/core/services/models/product/category_model.dart';
import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/pages/product/bloc/product_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final nameENController = TextEditingController();
  final nameARController = TextEditingController();
  final descriptionENController = TextEditingController();
  final descriptionARController = TextEditingController();
  final salePriceController = TextEditingController();
  final regularPriceController = TextEditingController();
  final baseCostController = TextEditingController();
  final weightController = TextEditingController();

  // Categories
  List<CategoryModel> availableCategories = [];
  final Set<CategoryModel> selectedCategories = {};

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    final categories = await getAllCategories();
    setState(() {
      availableCategories = categories;
    });
  }


  XFile? selectedImage;
  bool isImageRequired = true;

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
          "Add Product",
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
                                        border: Border.all(
                                          color:
                                              selectedImage == null &&
                                                      isImageRequired
                                                  ? Colors.red
                                                  : Colors.grey.shade300,
                                          width: 1,
                                        ),
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
                                                  if (isImageRequired)
                                                    Text(
                                                      "Required",
                                                      style: TextStyle(
                                                        color:
                                                            selectedImage ==
                                                                    null
                                                                ? Colors.red
                                                                : Colors
                                                                    .grey[600],
                                                        fontSize: 12,
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
                                                label: Text(category.ename),
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
                                _buildTextField(
                                  controller: nameENController,
                                  label: 'Product Name (EN)',
                                  isRequired: true,
                                ),
                                _buildTextField(
                                  controller: nameARController,
                                  label: 'Product Name (AR)',
                                  isRequired: true,
                                ),
                                _buildTextField(
                                  controller: descriptionENController,
                                  label: 'Description (EN)',
                                  maxLines: 3,
                                ),
                                _buildTextField(
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
                                      child: _buildTextField(
                                        controller: salePriceController,
                                        label: 'Sale Price',
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
                                      child: _buildTextField(
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
                                      child: _buildTextField(
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
                                      child: _buildTextField(
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
                                                label: Text(category.ename),
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
                                      if ((selectedImage != null ||
                                              !isImageRequired) &&
                                          _formKey.currentState!.validate()) {
                                        context.read<ProductBloc>().add(
                                          AddProduct(
                                            AddProductModel(
                                              eName: nameENController.text,
                                              arName: nameARController.text,
                                              eDescription:
                                                  descriptionENController.text,
                                              arDescription:
                                                  descriptionARController.text,
                                              salePrice:
                                                  double.tryParse(
                                                    salePriceController.text,
                                                  ) ??
                                                  0,
                                              regularPrice:
                                                  double.tryParse(
                                                    regularPriceController.text,
                                                  ) ??
                                                  0,
                                              baseCost:
                                                  double.tryParse(
                                                    baseCostController.text,
                                                  ) ??
                                                  0,
                                              weight:
                                                  double.tryParse(
                                                    weightController.text,
                                                  ) ??
                                                  0,
                                              categories: selectedCategories,
                                              image: XFile(selectedImage!.path),
                                              createdAt: DateTime.now(),
                                              updatedAt: DateTime.now(),
                                              id: 0,
                                            ),
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
                                      } else if (selectedImage == null &&
                                          isImageRequired) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Product image is required',
                                            ),
                                            backgroundColor: Colors.red,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isRequired = false,
    int maxLines = 1,
    TextInputType? keyboardType,
    Widget? prefixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.fontBlack),
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.secondary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator:
            isRequired
                ? (value) => value == null || value.isEmpty ? 'Required' : null
                : null,
      ),
    );
  }
}
