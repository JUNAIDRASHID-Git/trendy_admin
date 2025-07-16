class CategoryEvent {}

class FetchCategories extends CategoryEvent {}

class CreateCategory extends CategoryEvent {
  final String ename;
  final String arname;

  CreateCategory({required this.ename,required this.arname});
}

class UpdateCategory extends CategoryEvent {
  final int id;
  final String ename;
  final String arname;

  UpdateCategory({required this.id, required this.ename,required this.arname});
}

class DeleteCategory extends CategoryEvent {
  final int categoryId;
  DeleteCategory({required this.categoryId});
}
