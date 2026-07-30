// lib/core/logger/app_logger.dart

import 'package:logger/logger.dart';

/// Singleton wrapper for the Logger package.
class AppLogger {
  AppLogger._();

  static final AppLogger _instance = AppLogger._();
  static AppLogger get instance => _instance;

  // Minimal production-ready logger without emojis or colors.
  final Logger _logger = Logger();

  /// Log a debug message.
  static void d(dynamic message) {
    instance._logger.d(message);
  }

  /// Log an info message.
  static void i(dynamic message) {
    instance._logger.i(message);
  }

  /// Log a warning message.
  static void w(dynamic message) {
    instance._logger.w(message);
  }

  /// Log an error message.
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    instance._logger.e(message, error: error, stackTrace: stackTrace);
  }
}