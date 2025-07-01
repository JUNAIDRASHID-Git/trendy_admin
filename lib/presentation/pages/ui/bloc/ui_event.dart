// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ui_bloc.dart';

class UiEvent {}

class BannerFetchEvent extends UiEvent {}

class DeleteBannerEvent extends UiEvent {
  int bannerID;
  DeleteBannerEvent({required this.bannerID});
}
