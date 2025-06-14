class EditProductModel {
  final String eName;
  final String? arName;
  final String? eDescription;
  final String? arDescription;
  final double salePrice;
  final double regularPrice;
  final double baseCost;
  final double weight;
  final List<String> categories;
  final DateTime createdAt;
  final DateTime updatedAt;

  EditProductModel({
    required this.eName,
    required this.arName,
    required this.eDescription,
    required this.arDescription,
    required this.salePrice,
    required this.regularPrice,
    required this.baseCost,
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
      'categories': categories.join(','),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
