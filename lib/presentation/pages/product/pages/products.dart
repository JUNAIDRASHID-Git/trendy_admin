import 'package:admin_pannel/presentation/pages/product/bloc/product_bloc.dart';
import 'package:admin_pannel/presentation/pages/product/widgets/bar.dart/app_bar.dart';
import 'package:admin_pannel/presentation/pages/product/widgets/product_list_widget/product_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(FetchProduct()),
      child: Scaffold(
        appBar: appBar(context), body: ProductListView()),
    );
  }
}
