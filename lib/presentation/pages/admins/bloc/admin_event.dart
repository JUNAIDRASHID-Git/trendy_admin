abstract class AdminEvent {}

class FetchAllAdmin extends AdminEvent {}

class ApproveAdmin extends AdminEvent {
  final String email;

  ApproveAdmin({required this.email});
}

class RejectAdmin extends AdminEvent {
  final String email;

  RejectAdmin({required this.email});
}
