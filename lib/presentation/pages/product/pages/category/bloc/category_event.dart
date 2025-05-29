part of 'category_bloc.dart';

class CategoryEvent {}

class FetchCategories extends CategoryEvent {}

class CreateCategory extends CategoryEvent {
  final CategoryModel category;

  CreateCategory({required this.category});
}

class UpdateCategory extends CategoryEvent {
  final CategoryModel category;

  UpdateCategory({required this.category});
}

class DeleteCategory extends CategoryEvent {
  final int categoryId;

  DeleteCategory({required this.categoryId});
}
