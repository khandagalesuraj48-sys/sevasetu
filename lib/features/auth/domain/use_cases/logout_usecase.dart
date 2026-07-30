import '../data/repositories/auth_repository_impl.dart';

class LogoutUseCase {
  final AuthRepositoryImpl repository;

  LogoutUseCase(this.repository);

  Future<void> call(String token) async {
    await repository.logout(token);
  }
}