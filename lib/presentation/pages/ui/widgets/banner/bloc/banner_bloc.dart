import 'package:admin_pannel/core/services/api/ui/banner/post.dart';
import 'package:admin_pannel/presentation/pages/ui/widgets/banner/bloc/banner_event.dart';
import 'package:admin_pannel/presentation/pages/ui/widgets/banner/bloc/banner_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<UploadImageEvent>(_onUploadImage);
  }

  Future<void> _onPickImage(
    PickImageEvent event,
    Emitter<BannerState> emit,
  ) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result?.files.single.bytes != null) {
      emit(
        BannerImageSelected(
          result!.files.single.bytes!,
          result.files.single.name,
          result.files.single.path ?? "",
        ),
      );
    }
  }

  Future<void> _onUploadImage(
    UploadImageEvent event,
    Emitter<BannerState> emit,
  ) async {
    emit(BannerUploading());
    try {
      await uploadBannerWeb(event.imageBytes, event.fileName, event.url);
      emit(BannerUploadSuccess());
    } catch (e) {
      emit(BannerUploadFailure(e.toString()));
    }
  }
}
