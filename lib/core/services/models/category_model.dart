class CategoryModel {
  final int id;
  final String name;
  final List<dynamic> products;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['ID'],
      name: json['Name'],
      products: json['products'] ?? [],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.tryParse(json['deleted_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'products': products,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
