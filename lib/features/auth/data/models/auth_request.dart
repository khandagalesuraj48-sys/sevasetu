/// Request model for login and register.
class LoginRequest {
  final String phoneOrEmail;
  final String password;

  LoginRequest({
    required this.phoneOrEmail,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'phoneOrEmail': phoneOrEmail,
    'password': password,
  };
}

class RegisterRequest {
  final String name;
  final String phone;
  final String? email;
  final String password;

  RegisterRequest({
    required this.name,
    required this.phone,
    this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'email': email,
    'password': password,
  };
}