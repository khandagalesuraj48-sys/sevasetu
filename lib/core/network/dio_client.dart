// lib/core/network/dio_client.dart

import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

/// Singleton Dio client configured for the application.
class DioClient {
  DioClient._();

  static final DioClient _instance = DioClient._();
  static DioClient get instance => _instance;

  // Directly initialized. No 'late' keyword needed.
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.networkTimeout,
      receiveTimeout: AppConstants.networkTimeout,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  /// Returns the Dio client instance. Always ready.
  Dio get dio => _dio;
}