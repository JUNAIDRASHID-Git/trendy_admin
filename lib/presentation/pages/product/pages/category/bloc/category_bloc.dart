import 'package:admin_pannel/core/services/api/category/category.dart';
import 'package:admin_pannel/presentation/pages/product/pages/category/bloc/category_event.dart';
import 'package:admin_pannel/presentation/pages/product/pages/category/bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategories>((event, emit) async {
      try {
        emit(CategoryLoading());
        final categories = await getAllCategories();
        emit(CategoryLoaded(categories: categories));
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });

    on<CreateCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await createCategory(event.ename, event.arname);
        add(FetchCategories());
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });

    on<UpdateCategory>((event, emit) async {
      try {
        await updateCategory(event.id, event.ename, event.arname);
        add(FetchCategories());
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });

    on<DeleteCategory>((event, emit) async {
      try {
        await deleteCategory(event.categoryId);
        add(FetchCategories());
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
  }
}
