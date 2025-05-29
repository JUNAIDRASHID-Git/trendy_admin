import 'package:admin_pannel/core/services/api/admin_apis/admin.dart';
import 'package:admin_pannel/core/services/models/admin_models/admin_model.dart';
import 'package:admin_pannel/presentation/pages/admins/bloc/admin_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<FetchAllAdmin>((event, emit) async {
      emit(AdminLoading());
      try {
        final admins = await fetchAdminUsers();
        emit(AdminLoaded(admins));
      } catch (e) {
        emit(AdminError(e.toString()));
      }
    });
    on<ApproveAdmin>((event, emit) async {
      emit(AdminLoading());
      try {
        await approveAdmin(event.email);
        final admins = await fetchAdminUsers();
        emit(AdminLoaded(admins));
      } catch (e) {
        emit(AdminError(e.toString()));
      }
    });

    on<RejectAdmin>((event, emit) async {
      emit(AdminLoading());
      try {
        await rejectAdmin(event.email);
        final admins = await fetchAdminUsers();
        emit(AdminLoaded(admins));
      } catch (e) {
        emit(AdminError(e.toString()));
      }
    });
  }
}
