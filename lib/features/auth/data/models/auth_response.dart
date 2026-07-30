/// User model
class UserModel {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String? userType;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    phone: json['phone'] ?? '',
    email: json['email'],
    userType: json['userType'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'userType': userType,
  };
}

/// Authentication response
class AuthResponse {
  final bool success;
  final String? token;
  final UserModel? user;
  final String? message;

  AuthResponse({
    required this.success,
    this.token,
    this.user,
    this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    success: json['success'] ?? false,
    token: json['token'],
    user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    message: json['message'],
  );
}