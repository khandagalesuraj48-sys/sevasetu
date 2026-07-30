import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/auth_request.dart';
import '../models/auth_response.dart';

/// Remote data source for authentication APIs.
abstract class AuthRemoteDataSource {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> register(RegisterRequest request);
  Future<void> logout(String token);
}

/// Implementation of AuthRemoteDataSource
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio = DioClient.instance.dio;

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      // Handle error gracefully
      return AuthResponse(
        success: false,
        message: e.response?.data['message'] ?? e.message,
      );
    }
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      return AuthResponse(
        success: false,
        message: e.response?.data['message'] ?? e.message,
      );
    }
  }

  @override
  Future<void> logout(String token) async {
    await dio.post(
      '/auth/logout',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}