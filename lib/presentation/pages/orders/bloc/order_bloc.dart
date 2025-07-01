import 'package:admin_pannel/core/services/api/order/delete.dart';
import 'package:admin_pannel/core/services/api/order/get.dart';
import 'package:admin_pannel/core/services/api/order/put.dart';
import 'package:admin_pannel/core/services/models/order/order.dart';
import 'package:bloc/bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    // Fetch Orders
    on<FetchOrdersEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await getAllOrders();
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        emit(OrderError(error: 'Failed to fetch orders: $e'));
      }
    });

    // Edit Order Status
    on<EditOrderStatusEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        await editOrderStatus(event.orderID, event.status);
        final orders = await getAllOrders();
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        emit(OrderError(error: 'Failed to update order status: $e'));
      }
    });

    // Edit Payment Status
    on<EditOrderPaymentStatusEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        await editOrderPaymentStatus(event.orderID, event.paymentStatus);
        final orders = await getAllOrders();
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        emit(OrderError(error: 'Failed to update payment status: $e'));
      }
    });

    // Delete Order
    on<DeleteOrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        await deleteOrder(event.orderID);
        final orders = await getAllOrders();
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        emit(OrderError(error: 'Failed to delete order: $e'));
      }
    });
  }
}
