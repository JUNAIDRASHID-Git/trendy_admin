
import 'package:admin_pannel/core/services/models/product/category_model.dart';

class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  CategoryLoaded({required this.categories});
}

final class CategoryError extends CategoryState {
  String message;

  CategoryError({required this.message});
}
