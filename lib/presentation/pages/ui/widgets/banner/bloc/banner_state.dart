import 'dart:typed_data';

abstract class BannerState {
  const BannerState();
}

class BannerInitial extends BannerState {}

class BannerImageSelected extends BannerState {
  final Uint8List imageBytes;
  final String fileName;

  const BannerImageSelected(this.imageBytes, this.fileName);
}

class BannerUploading extends BannerState {}

class BannerUploadSuccess extends BannerState {}

class BannerUploadFailure extends BannerState {
  final String error;
  const BannerUploadFailure(this.error);
}
