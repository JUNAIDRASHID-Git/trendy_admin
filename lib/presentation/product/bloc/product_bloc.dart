import 'dart:developer';
import 'dart:typed_data';
import 'package:admin_pannel/core/services/api/excel_importer.dart';
import 'package:admin_pannel/core/services/api/product.dart';
import 'package:admin_pannel/core/services/models/add_product_model.dart';
import 'package:admin_pannel/core/services/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProduct>((event, emit) async {
      emit(ProductLoading());
      await Future.delayed(const Duration(seconds: 2));
      try {
        final product = await fetchAllProducts();
        emit(ProductLoaded(products: product));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });

    on<AddProduct>((event, emit) async {
      log('AddProduct event received');
      emit(ProductAddLoading());
      try {
        await addProduct(event.product, event.product.image);
        log('Product added successfully');
        emit(ProductAddSuccess());
        add(FetchProduct());
      } catch (e) {
        log('Error adding product: $e');
        emit(ProductAddFailure(error: e.toString()));
      }
    });

    on<UploadExcelFileEvent>((event, emit) async {
      emit(ExcelUploadInProgress());
      try {
        await uploadExcelProducts(
          fileName: event.fileName,
          fileBytes: event.excelBytes,
        );
        emit(ExcelUploadSuccess());
        add(FetchProduct());
      } catch (e) {
        emit(ExcelUploadFailure(error: e.toString()));
      }
    });

    on<ProductDeleteEvent>((event, emit) async {
      emit(ProductDeleteLoading());
      try {
        await deleteProduct(event.id);
        emit(ProductDeleteSuccess());
        add(FetchProduct());
      } catch (e) {
        emit(ProductDeleteFailure(error: e.toString()));
      }
    });
  }
}
