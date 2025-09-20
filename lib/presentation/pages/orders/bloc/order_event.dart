// order_event.dart
part of 'order_bloc.dart';

abstract class OrderEvent {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class FetchOrdersEvent extends OrderEvent {
  const FetchOrdersEvent();
}

class EditOrderStatusEvent extends OrderEvent {
  final int orderID;
  final String status;
  const EditOrderStatusEvent({required this.orderID, required this.status});

  @override
  List<Object?> get props => [orderID, status];
}

class EditOrderPaymentStatusEvent extends OrderEvent {
  final int orderID;
  final String paymentStatus;
  const EditOrderPaymentStatusEvent({
    required this.orderID,
    required this.paymentStatus,
  });

  @override
  List<Object?> get props => [orderID, paymentStatus];
}

class EditOrderShippingCostEvent extends OrderEvent {
  final int orderID;
  final double shippingCost;
  const EditOrderShippingCostEvent({
    required this.orderID,
    required this.shippingCost,
  });

  @override
  List<Object?> get props => [orderID, shippingCost];
}

class DeleteOrderEvent extends OrderEvent {
  final int orderID;
  const DeleteOrderEvent({required this.orderID});

  @override
  List<Object?> get props => [orderID];
}
