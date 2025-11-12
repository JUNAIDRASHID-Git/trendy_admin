// order_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:admin_pannel/core/services/api/order/get.dart';
import 'package:admin_pannel/core/services/api/order/delete.dart';
import 'package:admin_pannel/core/services/api/order/put.dart';
import 'package:admin_pannel/core/services/models/order/order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super( OrderInitial()) {
    // Fetch Orders
    on<FetchOrdersEvent>(_onFetchOrders);

    // Edit Order Status
    on<EditOrderStatusEvent>(_onEditOrderStatus);

    // Edit Payment Status
    on<EditOrderPaymentStatusEvent>(_onEditPaymentStatus);

    // Delete Order
    on<DeleteOrderEvent>(_onDeleteOrder);
  }

  Future<void> _onFetchOrders(FetchOrdersEvent event, Emitter<OrderState> emit) async {
    emit( OrderLoading());
    try {
      final orders = await getAllOrders();
      emit(OrderLoaded(orders: orders));
    } catch (e) {
      emit(OrderError(error: 'Failed to fetch orders: ${e.toString()}'));
    }
  }

  Future<void> _onEditOrderStatus(EditOrderStatusEvent event, Emitter<OrderState> emit) async {
    emit( OrderLoading());
    try {
      await editOrderStatus(event.orderID, event.status);
      final orders = await getAllOrders();
      emit(OrderLoaded(orders: orders));
    } catch (e) {
      emit(OrderError(error: 'Failed to update order status: ${e.toString()}'));
    }
  }

  Future<void> _onEditPaymentStatus(EditOrderPaymentStatusEvent event, Emitter<OrderState> emit) async {
    emit( OrderLoading());
    try {
      await editOrderPaymentStatus(event.orderID, event.paymentStatus);
      final orders = await getAllOrders();
      emit(OrderLoaded(orders: orders));
    } catch (e) {
      emit(OrderError(error: 'Failed to update payment status: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteOrder(DeleteOrderEvent event, Emitter<OrderState> emit) async {
    emit( OrderLoading());
    try {
      await deleteOrder(event.orderID);
      final orders = await getAllOrders();
      emit(OrderLoaded(orders: orders));
    } catch (e) {
      emit(OrderError(error: 'Failed to delete order: ${e.toString()}'));
    }
  }
}
