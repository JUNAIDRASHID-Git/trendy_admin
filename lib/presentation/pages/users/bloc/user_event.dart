abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class FetchUserCart extends UserEvent {
  final String userId;

  FetchUserCart(this.userId);
}
