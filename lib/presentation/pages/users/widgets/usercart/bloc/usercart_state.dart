import 'package:admin_pannel/core/services/models/cart/cart.dart';


abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> cartItems;
  CartLoaded(this.cartItems);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
