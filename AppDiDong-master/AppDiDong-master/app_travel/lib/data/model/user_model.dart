class User {
  int userId;
  String name;
  String email;
  String phone;
  String address;
  String password;
  DateTime createdAt;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      password: json['password'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
