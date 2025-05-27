part of 'admin_bloc.dart';

class AdminState {}

final class AdminInitial extends AdminState {}

final class AdminLoading extends AdminState {}

final class AdminLoaded extends AdminState {
  final List<Admin> admins;

  AdminLoaded(this.admins);
}

final class AdminError extends AdminState {
  final String message;

  AdminError(this.message);
}
