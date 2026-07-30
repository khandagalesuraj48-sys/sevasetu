// lib/core/env/environment.dart

/// Environment types supported by the application.
enum Environment {
  dev,
  staging,
  production,
}

/// Simple environment configuration – immutable for V1.
class EnvConfig {
  EnvConfig._();

  /// Default environment is development.
  static const Environment _currentEnv = Environment.dev;

  /// Returns the current environment.
  static Environment get current => _currentEnv;

  /// Returns true if the current environment is development.
  static bool get isDev => _currentEnv == Environment.dev;

  /// Returns true if the current environment is staging.
  static bool get isStaging => _currentEnv == Environment.staging;

  /// Returns true if the current environment is production.
  static bool get isProduction => _currentEnv == Environment.production;
}