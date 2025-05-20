part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  ProductLoaded({required this.products});
}

class ProductError extends ProductState {
  final String message;
  ProductError({required this.message});
}

// New states for adding product
class ProductAddLoading extends ProductState {}

class ProductAddSuccess extends ProductState {}

class ProductAddFailure extends ProductState {
  final String error;

  ProductAddFailure({required this.error});
}