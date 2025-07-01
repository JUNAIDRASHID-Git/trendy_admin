class CategoryModel {
  final int id;
  final String ename;
  final String arname;

  CategoryModel({
    required this.id,
    required this.ename,
    required this.arname,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['ID'],
      ename: json['EName'],
      arname: json['ARName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'EName': ename,
      'ARName': arname,
    };
  }
}
