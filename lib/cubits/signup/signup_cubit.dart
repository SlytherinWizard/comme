import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupState.initial());

  /// Update email field
  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  /// Update password field
  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  /// Update confirm password field
  void confirmPasswordChanged(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  /// Update display name field
  void displayNameChanged(String displayName) {
    emit(state.copyWith(displayName: displayName));
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  /// Clear form
  void clearForm() {
    emit(SignupState.initial());
  }

  /// Validate form
  String? validateForm() {
    if (state.displayName.isEmpty) {
      return 'Display name is required';
    }
    if (state.email.isEmpty) {
      return 'Email is required';
    }
    if (!_isValidEmail(state.email)) {
      return 'Please enter a valid email';
    }
    if (state.password.isEmpty) {
      return 'Password is required';
    }
    if (state.password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (state.confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (state.password != state.confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Email validation helper
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  /// Check if form is valid
  bool isFormValid() {
    return validateForm() == null;
  }
}
