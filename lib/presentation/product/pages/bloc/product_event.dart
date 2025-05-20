part of 'product_bloc.dart';

abstract class ProductEvent {}

class FetchProduct extends ProductEvent{}

class AddProduct extends ProductEvent {
  final AddProductModel product;

  AddProduct(this.product);
}
