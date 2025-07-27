abstract class CartEvent {}

class LoadCartItems extends CartEvent {
  final String userId;

  LoadCartItems(this.userId);
}
