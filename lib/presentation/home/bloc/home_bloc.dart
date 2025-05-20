import 'package:admin_pannel/core/services/api/product.dart';
import 'package:admin_pannel/core/services/api/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchCountsEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final users = await fetchAllUsers();
        // final admins = await fetchAllAdmins(); // Implement this
        final products = await fetchAllProducts(); // Implement this
        // final orders = await fetchAllOrders(); // Implement this
        // final sales = await fetchTotalSales(); // Implement this

        emit(
          HomeLoaded(
            usersCount: users.length,
            // adminsCount: admins.length,
            productsCount: products.length,
            // ordersCount: orders.length,
            // totalSales: sales,
          ),
        );
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
