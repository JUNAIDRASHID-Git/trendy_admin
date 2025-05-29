part of 'category_bloc.dart';

class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CatogoryLoading extends CategoryState {}

final class CatogoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  CatogoryLoaded({required this.categories});
}

final class CategoryError extends CategoryState {
  String message;

  CategoryError({required this.message});
}
