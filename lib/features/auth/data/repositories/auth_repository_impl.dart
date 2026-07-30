import '../datasources/auth_remote_ds.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_request.dart';
import '../models/auth_response.dart';

/// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    return await remoteDataSource.login(request);
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    return await remoteDataSource.register(request);
  }

  @override
  Future<void> logout(String token) async {
    await remoteDataSource.logout(token);
  }
}