import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/pages/category/bloc/category_bloc.dart';
import 'package:admin_pannel/presentation/pages/category/bloc/category_event.dart';
import 'package:admin_pannel/presentation/pages/category/widgets/builder.dart';
import 'package:admin_pannel/presentation/widgets/buttons/primary.dart';
import 'package:admin_pannel/presentation/widgets/dialogs/form_dialog.dart';
import 'package:admin_pannel/presentation/widgets/text/heading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,
          title: headingText("Categories", AppColors.fontBlack),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: primaryBtn(
                action: () {
                  formDialog(
                    context,
                    onSave: (data) {
                      final ename = data['en'] ?? '';
                      final arname = data['ar'] ?? '';
                      context.read<CategoryBloc>().add(
                        CreateCategory(ename: ename, arname: arname),
                      );
                    },
                  );
                },
                text: "New Category",
              ),
            ),
          ],
        ),
        body: catogoryList(),
      ),
    );
  }
}
