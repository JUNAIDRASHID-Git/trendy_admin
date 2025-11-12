import 'dart:typed_data';

abstract class BannerEvent {
  const BannerEvent();
}

class PickImageEvent extends BannerEvent {}

class UploadImageEvent extends BannerEvent {
  final Uint8List imageBytes;
  final String fileName;
  final String url;

  const UploadImageEvent(this.imageBytes, this.fileName,this.url);
}
