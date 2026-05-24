part of 'signup_cubit.dart';

enum SignupStatus { initial, loading, success, error }

class SignupState {
  final SignupStatus status;
  final String displayName;
  final String email;
  final String password;
  final String confirmPassword;
  final String? errorMessage;
  final bool obscurePassword;

  SignupState({
    required this.status,
    required this.displayName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.errorMessage,
    this.obscurePassword = true,
  });

  factory SignupState.initial() {
    return SignupState(
      status: SignupStatus.initial,
      displayName: '',
      email: '',
      password: '',
      confirmPassword: '',
      errorMessage: null,
      obscurePassword: true,
    );
  }

  SignupState copyWith({
    SignupStatus? status,
    String? displayName,
    String? email,
    String? password,
    String? confirmPassword,
    String? errorMessage,
    bool? obscurePassword,
  }) {
    return SignupState(
      status: status ?? this.status,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      errorMessage: errorMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}
