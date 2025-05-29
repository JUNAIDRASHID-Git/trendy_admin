import 'package:admin_pannel/core/services/api/product/category/category.dart';
import 'package:admin_pannel/core/services/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategories>((event, emit) async {
      try {
        emit(CatogoryLoading());
        final categories = await getAllCategories();
        emit(CatogoryLoaded(categories: categories));
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
  }
}
