// lib/core/utils/validators.dart

/// Static validation utility class.
class Validators {
  Validators._();

  // Standard ASCII-only email regex (avoids Unicode smart quote issues).
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _phoneRegExp = RegExp(r'^[6-9]\d{9}$');

  /// Returns true if the provided email is valid.
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    return _emailRegExp.hasMatch(email);
  }

  /// Returns true if the provided phone number is valid (10-digit Indian).
  static bool isValidPhone(String phone) {
    if (phone.isEmpty) return false;
    return _phoneRegExp.hasMatch(phone);
  }

  /// Returns true if the password is valid (minimum 8 characters).
  static bool isValidPassword(String password) {
    if (password.isEmpty) return false;
    return password.length >= 8;
  }
}