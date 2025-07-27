
import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/pages/product/pages/category/bloc/category_bloc.dart';
import 'package:admin_pannel/presentation/pages/product/pages/category/bloc/category_event.dart';
import 'package:admin_pannel/presentation/pages/product/pages/category/bloc/category_state.dart';
import 'package:admin_pannel/presentation/pages/product/pages/category/widgets/dialogs.dart';
import 'package:admin_pannel/presentation/widgets/buttons/delete.dart';
import 'package:admin_pannel/presentation/widgets/buttons/edit.dart';
import 'package:admin_pannel/presentation/widgets/dialogs/form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

BlocProvider<CategoryBloc> catogoryList() {
  return BlocProvider(
    create: (_) => CategoryBloc()..add(FetchCategories()),
    child: BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryInitial || state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        } else if (state is CategoryError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else if (state is CategoryLoaded) {
          final categories = state.categories;

          if (categories.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No categories found",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Create your first category to get started",
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "ID",
                          style: TextStyle(
                            color: AppColors.fontWhite,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Category Name",
                          style: TextStyle(
                            color: AppColors.fontWhite,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Actions",
                          style: TextStyle(
                            color: AppColors.fontWhite,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                // Categories List
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: categories.length,
                      separatorBuilder:
                          (context, index) => Divider(
                            height: 1,
                            color: Colors.grey[200],
                            indent: 24,
                            endIndent: 24,
                          ),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          child: Row(
                            children: [
                              // ID
                              Expanded(
                                flex: 1,
                                child: Text(
                                  category.id.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              // Category Name
                              Expanded(
                                flex: 3,
                                child: Text(
                                  category.ename,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),

                              // Actions
                              Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    editBtn(
                                      action: () {
                                        formDialog(
                                          context,
                                          initialValue: {
                                            'en': category.ename,
                                            'ar': category.arname,
                                          },
                                          title: "Edit Category",
                                          onSave: (value) {
                                            context.read<CategoryBloc>().add(
                                              UpdateCategory(
                                                id: category.id,
                                                ename: value['en'] ?? '',
                                                arname: value['ar'] ?? '',
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 12),
                                    deleteBtn(
                                      action: () {
                                        showAppDialog(context, category, () {
                                          context.read<CategoryBloc>().add(
                                            DeleteCategory(
                                              categoryId: category.id,
                                            ),
                                          );
                                          Navigator.pop(context);

                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    ),
  );
}
