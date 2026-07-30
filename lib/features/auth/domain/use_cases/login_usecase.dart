import '../data/models/auth_request.dart';
import '../data/models/auth_response.dart';
import '../data/repositories/auth_repository_impl.dart';

class LoginUseCase {
  final AuthRepositoryImpl repository;

  LoginUseCase(this.repository);

  Future<AuthResponse> call(LoginRequest request) async {
    return await repository.login(request);
  }
}