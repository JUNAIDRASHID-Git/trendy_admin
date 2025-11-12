// home_state.dart
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final int usersCount;
  final int adminsCount;
  final int productsCount;
  final int ordersCount;
  // final double totalSales;

  HomeLoaded({
    required this.usersCount,
    required this.adminsCount,
    required this.productsCount,
    required this.ordersCount,
    // required this.totalSales,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
