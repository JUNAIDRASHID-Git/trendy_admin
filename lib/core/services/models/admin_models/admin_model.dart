class Admin {
  final int id;
  final String email;
  final String name;
  final String picture;
  final bool approved;

  Admin({
    required this.id,
    required this.email,
    required this.name,
    required this.picture,
    required this.approved,
  });

  // Factory constructor to create an Admin from JSON
  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['ID'] as int,
      email: json['Email'] as String,
      name: json['Name'] as String,
      picture: json['Picture'] as String,
      approved: json['Approved'] as bool,
    );
  }

  // Method to convert Admin to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'picture': picture,
      'approved': approved,
    };
  }
}
