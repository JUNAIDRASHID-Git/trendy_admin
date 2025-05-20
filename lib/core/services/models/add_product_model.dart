

import 'package:image_picker/image_picker.dart';

class AddProductModel {
  final int? id;
  final String name;
  final String? description;
  final double salePrice;
  final double regularPrice;
  final double baseCost;
  final XFile image;
  final double weight;
  final List<String> categories;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddProductModel({
    this.id,
    required this.name,
    this.description,
    required this.salePrice,
    required this.regularPrice,
    required this.baseCost,
    required this.image,
    required this.weight,
    required this.categories,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'sale_price': salePrice.toString(),
      'regular_price': regularPrice.toString(),
      'base_cost': baseCost.toString(),
      'weight': weight.toString(),
      'Categories': categories.join(","),
      'CreatedAt': createdAt.toIso8601String(),
      'UpdatedAt': updatedAt.toIso8601String(),
    };
  }
}
