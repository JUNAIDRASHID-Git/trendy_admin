// ignore_for_file: public_member_api_docs, sort_constructors_first
class BannerModel {
  int id;
  String imageUrl;
  BannerModel({required this.id, required this.imageUrl});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(id: json['ID'], imageUrl: json['ImageURL']);
  }
}
