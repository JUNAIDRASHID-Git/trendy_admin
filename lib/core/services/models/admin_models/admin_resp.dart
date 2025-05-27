class AdminAuthResponse {
  final String email;
  final String name;
  final String picture;
  final String role;
  final String token;

  AdminAuthResponse({
    required this.email,
    required this.name,
    required this.picture,
    required this.role,
    required this.token,
  });

  factory AdminAuthResponse.fromJson(Map<String, dynamic> json) {
    return AdminAuthResponse(
      email: json['email'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String,
      role: json['role'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'picture': picture,
    'role': role,
    'token': token,
  };

  @override
  String toString() {
    return 'AdminAuthResponse(email: $email, name: $name, role: $role)';
  }
}
