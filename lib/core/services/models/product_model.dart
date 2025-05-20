class ProductModel {
  final int? id;
  final String name;
  final String? description;
  final double salePrice;
  final double regularPrice;
  final double baseCost;
  final String image;
  final double weight;
  final List<String> categories;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['ID'] ?? 0,
      name: json['Name'] ?? '',
      description: json['Description'],
      salePrice: (json['SalePrice'] as num?)?.toDouble() ?? 0.0,
      regularPrice: (json['RegularPrice'] as num?)?.toDouble() ?? 0.0,
      baseCost: (json['BaseCost'] as num?)?.toDouble() ?? 0.0,
      image: json['Image'] ?? '',
      weight: (json['Weight'] as num?)?.toDouble() ?? 0.0,
      categories:
          (json['Categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      createdAt: DateTime.tryParse(json['CreatedAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['UpdatedAt'] ?? '') ?? DateTime.now(),
    );
  }

}
