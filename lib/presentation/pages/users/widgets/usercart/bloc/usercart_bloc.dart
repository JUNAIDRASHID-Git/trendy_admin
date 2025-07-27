import 'package:admin_pannel/core/services/api/user_cart/user_cart.dart';
import 'package:admin_pannel/presentation/pages/users/widgets/usercart/bloc/usercart_event.dart';
import 'package:admin_pannel/presentation/pages/users/widgets/usercart/bloc/usercart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCartItems>(_onLoadCartItems);
  }

  Future<void> _onLoadCartItems(
    LoadCartItems event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final cartItems = await fetchCartItems(event.userId);

      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(CartError("Failed to load cart items."));
    }
  }
}
