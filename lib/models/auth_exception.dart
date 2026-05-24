/// Custom exception class for authentication errors
class AuthException implements Exception {
  final String message;
  final String? code;

  AuthException({required this.message, this.code});

  @override
  String toString() =>
      'AuthException: $message${code != null ? ' (Code: $code)' : ''}';

  /// Parse Firebase error codes into user-friendly messages
  factory AuthException.fromFirebaseCode(String code, String message) {
    switch (code) {
      case 'user-not-found':
        return AuthException(
          message: 'No user found with this email address.',
          code: code,
        );
      case 'wrong-password':
        return AuthException(
          message: 'Incorrect password. Please try again.',
          code: code,
        );
      case 'email-already-in-use':
        return AuthException(
          message: 'This email address is already in use.',
          code: code,
        );
      case 'weak-password':
        return AuthException(
          message: 'Password is too weak. Please use a stronger password.',
          code: code,
        );
      case 'invalid-email':
        return AuthException(
          message: 'Invalid email address. Please check and try again.',
          code: code,
        );
      case 'operation-not-allowed':
        return AuthException(
          message: 'This operation is not allowed. Contact support.',
          code: code,
        );
      case 'too-many-requests':
        return AuthException(
          message: 'Too many attempts. Please try again later.',
          code: code,
        );
      case 'network-request-failed':
        return AuthException(
          message: 'Network error. Please check your connection.',
          code: code,
        );
      case 'requires-recent-login':
        return AuthException(
          message: 'Please log in again before performing this action.',
          code: code,
        );
      case 'user-disabled':
        return AuthException(
          message: 'This user account has been disabled.',
          code: code,
        );
      default:
        return AuthException(
          message: message.isNotEmpty
              ? message
              : 'An authentication error occurred.',
          code: code,
        );
    }
  }
}
