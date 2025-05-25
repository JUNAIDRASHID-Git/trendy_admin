import 'package:admin_pannel/core/theme/colors.dart';
import 'package:admin_pannel/presentation/home/bloc/home_bloc.dart';
import 'package:admin_pannel/presentation/home/bloc/home_state.dart';
import 'package:admin_pannel/presentation/home/widgets/total_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "DashBoard",
            style: TextStyle(color: AppColors.fontWhite),
          ),
          backgroundColor: AppColors.primary,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 200,
                  ),
                  children: [
                    totalContainer(title: "Admins", total: 0),
                    totalContainer(title: "Users", total: state.usersCount),
                    totalContainer(
                      title: "Products",
                      total: state.productsCount,
                    ),
                    totalContainer(title: "Order", total: 0),
                    totalContainerPrices(title: "Sales", total: 0),
                  ],
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text("Error: ${state.message}"));
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
