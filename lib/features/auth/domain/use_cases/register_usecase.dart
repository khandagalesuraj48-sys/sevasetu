import '../data/models/auth_request.dart';
import '../data/models/auth_response.dart';
import '../data/repositories/auth_repository_impl.dart';

class RegisterUseCase {
  final AuthRepositoryImpl repository;

  RegisterUseCase(this.repository);

  Future<AuthResponse> call(RegisterRequest request) async {
    return await repository.register(request);
  }
}