part of 'product_bloc.dart';

abstract class ProductEvent {}

class FetchProduct extends ProductEvent {}

// This event is used to add a new product.
// The product parameter is an instance of AddProductModel,

class AddProduct extends ProductEvent {
  final AddProductModel product;

  AddProduct(this.product);
}

// upload excel file event
// This event is used to upload an excel file containing product data.
// The file name and the bytes of the excel file are required parameters.
// The event is used to trigger the upload process in the BLoC.
// The file name is a string that represents the name of the excel file.
// The excelBytes is a Uint8List that contains the bytes of the excel file.
// The event is used to upload the excel file to the server.

class UploadExcelFileEvent extends ProductEvent {
  final String fileName;
  final Uint8List excelBytes;

  UploadExcelFileEvent({required this.fileName, required this.excelBytes});
}

// delete product event

class ProductDeleteEvent extends ProductEvent {
  final int id;

  ProductDeleteEvent(this.id);
}

// update product event

class ProductUpdateEvent extends ProductEvent {
  final int id;
  final EditProductModel product;
  final XFile? image;

  ProductUpdateEvent(this.id, this.product,this.image);
}
