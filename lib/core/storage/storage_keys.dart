/// Constants for storage keys used across the app.
class StorageKeys {
  StorageKeys._();

  // ---- Auth ----
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userType = 'user_type';

  // ---- User ----
  static const String userEmail = 'user_email';
  static const String userPhone = 'user_phone';
  static const String userName = 'user_name';

  // ---- Settings ----
  static const String themeMode = 'theme_mode';
  static const String language = 'language';
  static const String firstLaunch = 'first_launch';

  // ---- Misc ----
  static const String deviceId = 'device_id';
  static const String fcmToken = 'fcm_token';
}