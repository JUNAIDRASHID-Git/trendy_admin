import 'package:admin_pannel/core/services/api/ui/banner/delete.dart';
import 'package:admin_pannel/core/services/api/ui/banner/get.dart';
import 'package:admin_pannel/core/services/models/banner/banner.dart';
import 'package:bloc/bloc.dart';

part 'ui_event.dart';
part 'ui_state.dart';

class UiBloc extends Bloc<UiEvent, UiState> {
  UiBloc() : super(UiInitial()) {
    on<BannerFetchEvent>((event, emit) async {
      emit(UiLoading());
      try {
        final banners = await getBanners();
        emit(UiLoaded(banners: banners));
      } catch (e) {
        emit(UiError(e.toString()));
      }
    });
    on<DeleteBannerEvent>((event, emit) async {
      emit(UiLoading());
      try {
        await deleteBanner(bannerID: event.bannerID);
        final banners = await getBanners();
        emit(UiLoaded(banners: banners));
      } catch (e) {
        emit(UiError(e.toString()));
      }
    });
  }
}
