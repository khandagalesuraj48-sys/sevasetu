import '../../data/models/auth_request.dart';
import '../../data/models/auth_response.dart';

/// Abstract repository interface for authentication.
abstract class AuthRepository {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> register(RegisterRequest request);
  Future<void> logout(String token);
}