// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

class OrderEvent {}

class FetchOrdersEvent extends OrderEvent {}

class EditOrderStatusEvent extends OrderEvent {
  int orderID;
  String status;
  EditOrderStatusEvent({required this.orderID, required this.status});
}

class EditOrderPaymentStatusEvent extends OrderEvent {
  int orderID;
  String paymentStatus;
  EditOrderPaymentStatusEvent({
    required this.orderID,
    required this.paymentStatus,
  });
}

class DeleteOrderEvent extends OrderEvent {
  int orderID;
  DeleteOrderEvent({required this.orderID});
}
