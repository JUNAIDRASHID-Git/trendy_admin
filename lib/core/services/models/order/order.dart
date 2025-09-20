import 'package:admin_pannel/core/services/models/user/user_model.dart';

class OrderModel {
  final int id;
  final String userId;
  final UserModel user;
  final List<OrderItem> items;
  final double shippingCost;
  final double totalAmount;
  final String status;
  final String paymentStatus;
  final String paymentMethod;
  final String orderRef;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.user,
    required this.items,
    required this.shippingCost,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.orderRef,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      user: UserModel.fromJson(json['user']),
      items:
          (json['items'] as List)
              .map((item) => OrderItem.fromJson(item))
              .toList(),
      shippingCost: (json['shipping_cost'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: json['status'],
      paymentStatus: json['payment_status'],
      paymentMethod: json['payment_method'] ?? '',
      orderRef: json['order_ref'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'user': user.toJson(),
    'items': items.map((e) => e.toJson()).toList(),
    'shipping_cost': shippingCost,
    'total_amount': totalAmount,
    'status': status,
    'payment_status': paymentStatus,
    'payment_method': paymentMethod,
    'order_ref': orderRef,
    'created_at': createdAt.toIso8601String(),
  };
}

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final String productEName;
  final String productArName;
  final String productImage;
  final double productSalePrice;
  final double productRegularPrice;
  final double weight;
  final int quantity;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productEName,
    required this.productArName,
    required this.productImage,
    required this.productSalePrice,
    required this.productRegularPrice,
    required this.weight,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['ID'],
      orderId: json['OrderID'],
      productId: json['ProductID'],
      productEName: json['product_e_name'],
      productArName: json['product_ar_name'],
      productImage: json['product_image'],
      productSalePrice: (json['product_sale_price'] as num).toDouble(),
      productRegularPrice: (json['product_regular_price'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'OrderID': orderId,
    'ProductID': productId,
    'product_e_name': productEName,
    'product_ar_name': productArName,
    'product_image': productImage,
    'product_sale_price': productSalePrice,
    'product_regular_price': productRegularPrice,
    'weight': weight,
    'quantity': quantity,
  };
}
