import 'dart:developer';
import 'dart:typed_data';
import 'package:admin_pannel/core/services/api/excel/excel_importer.dart';
import 'package:admin_pannel/core/services/api/product/product.dart';
import 'package:admin_pannel/core/services/models/product/add_product_model.dart';
import 'package:admin_pannel/core/services/models/product/editproduct_model.dart';
import 'package:admin_pannel/core/services/models/product/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProduct>((event, emit) async {
      emit(ProductLoading());
      await Future.delayed(const Duration(seconds: 1));
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
        final product = await fetchAllProducts();
        emit(ProductLoaded(products: product));
        log('Product added successfully');
        emit(ProductAddSuccess());
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

    on<ProductUpdateEvent>((event, emit) async {
      emit(ProductUpdateLoading());
      try {
        await updateProduct(event.id, event.product, imageFile: event.image);
        emit(ProductUpdateSuccess());
        add(FetchProduct());
      } catch (e) {
        emit(ProductUpdateFailure(error: e.toString()));
      }
    });
  }
}
