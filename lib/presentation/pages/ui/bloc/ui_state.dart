// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ui_bloc.dart';

class UiState {}

class UiInitial extends UiState {}

class UiLoading extends UiState {}

class UiLoaded extends UiState {
  List<BannerModel> banners;
  UiLoaded({required this.banners});
}

class UiError extends UiState {
  final String error;

  UiError(this.error);
}
