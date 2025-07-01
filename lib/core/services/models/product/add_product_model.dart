import 'package:admin_pannel/core/services/models/product/category_model.dart';
import 'package:image_picker/image_picker.dart';

class AddProductModel {
  final int? id;
  final String eName;
  final String? arName;
  final String? eDescription;
  final String? arDescription;
  final double salePrice;
  final double regularPrice;
  final double baseCost;
  final XFile image;
  final double weight;
  final Set<CategoryModel> categories;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddProductModel({
    this.id,
    required this.eName,
    this.arName,
    this.eDescription,
    this.arDescription,
    required this.salePrice,
    required this.regularPrice,
    required this.baseCost,
    required this.image,
    required this.weight,
    required this.categories,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Converts all fields except the image (XFile) to a JSON map.
  /// Use this when sending multipart/form-data, and attach the image separately.
  Map<String, String> toJson() {
    return {
      'ename': eName,
      if (arName != null) 'arname': arName!,
      if (eDescription != null) 'edescription': eDescription!,
      if (arDescription != null) 'ardescription': arDescription!,
      'sale_price': salePrice.toString(),
      'regular_price': regularPrice.toString(),
      'base_cost': baseCost.toString(),
      'weight': weight.toString(),
      'category_ids': categories.map((c) => c.id.toString()).join(','),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
