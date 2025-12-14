class CategoryModel {
  final int id;
  final String ename;
  final String arname;
  final String? image;

  CategoryModel({
    required this.id,
    required this.ename,
    required this.arname,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['ID'],
      ename: json['EName'],
      arname: json['ARName'],
      image: json['Image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'EName': ename,
      'ARName': arname,
      'Image': image,
    };
  }
}
