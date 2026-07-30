// lib/core/constants/app_constants.dart

/// Application-wide constants.
class AppConstants {
  AppConstants._();

  /// The name of the application.
  static const String appName = 'SevaSetu';

  /// The current version of the application.
  static const String appVersion = '1.0.0';

  /// The base URL for all API requests.
  static const String baseUrl = 'https://api.sevasetu.com/v1/';

  /// Default network timeout duration.
  static const Duration networkTimeout = Duration(seconds: 30);
}