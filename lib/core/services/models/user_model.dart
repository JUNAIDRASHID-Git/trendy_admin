class UserModel {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String picture;
  final String provider;
  final Address address;
  final List<CartItem> cartItems;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.picture,
    required this.provider,
    required this.address,
    required this.cartItems,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserModel(
        id: json['ID'] as String? ?? (throw FormatException('Missing ID')),
        email:
            json['Email'] as String? ??
            (throw FormatException('Missing Email')),
        name: json['Name'] as String? ?? '',
        phone: json['Phone'] as String? ?? '',
        picture: json['Picture'] as String? ?? '',
        provider: json['Provider'] as String? ?? '',
        address:
            json['Address'] != null
                ? Address.fromJson(json['Address'] as Map<String, dynamic>)
                : Address.empty(),
        cartItems:
            json['CartItems'] != null && json['CartItems'] is List
                ? (json['CartItems'] as List)
                    .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
                    .toList()
                : [],
        createdAt:
            DateTime.tryParse(json['CreatedAt'] as String? ?? '') ??
            DateTime.now(),
      );
    } catch (e) {
      // Optionally log or handle error here
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Email': email,
      'Name': name,
      'Phone': phone,
      'Picture': picture,
      'Provider': provider,
      'Address': address.toJson(),
      'CartItems': cartItems.map((item) => item.toJson()).toList(),
      'CreatedAt': createdAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? picture,
    String? provider,
    Address? address,
    List<CartItem>? cartItems,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      picture: picture ?? this.picture,
      provider: provider ?? this.provider,
      address: address ?? this.address,
      cartItems: cartItems ?? this.cartItems,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, phone: $phone, picture: $picture, provider: $provider, address: $address, cartItems: $cartItems, createdAt: $createdAt)';
  }
}

class Address {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['Street'] as String? ?? '',
      city: json['City'] as String? ?? '',
      state: json['State'] as String? ?? '',
      postalCode: json['PostalCode'] as String? ?? '',
      country: json['Country'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
    };
  }

  static Address empty() =>
      Address(street: '', city: '', state: '', postalCode: '', country: '');

  @override
  String toString() {
    return 'Address(street: $street, city: $city, state: $state, postalCode: $postalCode, country: $country)';
  }
}

class CartItem {
  final int id;
  final String userId;
  final String productId;
  final int quantity;
  final DateTime addedAt;

  CartItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.addedAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['ID'] as int? ?? 0,
      userId: json['UserID'] as String? ?? '',
      productId: json['ProductID'] as String? ?? '',
      quantity: json['Quantity'] as int? ?? 1,
      addedAt:
          DateTime.tryParse(json['AddedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'UserID': userId,
      'ProductID': productId,
      'Quantity': quantity,
      'AddedAt': addedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'CartItem(id: $id, userId: $userId, productId: $productId, quantity: $quantity, addedAt: $addedAt)';
  }
}
