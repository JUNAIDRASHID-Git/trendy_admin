import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_pannel/core/services/api/user/user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await fetchAllUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError("Failed to fetch users"));
      }
    });
  }
}
