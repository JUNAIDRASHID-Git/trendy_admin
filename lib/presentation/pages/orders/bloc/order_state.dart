// order_state.dart
part of 'order_bloc.dart';

abstract class OrderState {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  const OrderLoaded({required this.orders});

  @override
  List<Object?> get props => [orders];
}

class OrderError extends OrderState {
  final String error;
  const OrderError({required this.error});

  @override
  List<Object?> get props => [error];
}
