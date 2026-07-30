import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Singleton wrapper for FlutterSecureStorage.
class SecureStorageService {
  SecureStorageService._();
  static final SecureStorageService _instance = SecureStorageService._();
  static SecureStorageService get instance => _instance;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Write a value securely.
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read a value securely.
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete a value securely.
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Check if a key exists.
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  /// Delete all keys.
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Read all keys and values.
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
}