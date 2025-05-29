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

// New states for uploading Excel file

class ExcelUploadInProgress extends ProductState {}

class ExcelUploadSuccess extends ProductState {}

class ExcelUploadFailure extends ProductState {
  final String error;
  ExcelUploadFailure({required this.error});
}

class ProductDeleteLoading extends ProductState {}

class ProductDeleteSuccess extends ProductState {}

class ProductDeleteFailure extends ProductState {
  final String error;
  ProductDeleteFailure({required this.error});
}

// New states for updating product

class ProductUpdateLoading extends ProductState {}

class ProductUpdateSuccess extends ProductState {}

class ProductUpdateFailure extends ProductState {
  final String error;
  ProductUpdateFailure({required this.error});
}
