part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState {
  final LoginStatus status;
  final String email;
  final String password;
  final String? errorMessage;
  final bool obscurePassword;

  LoginState({
    required this.status,
    required this.email,
    required this.password,
    this.errorMessage,
    this.obscurePassword = true,
  });

  factory LoginState.initial() {
    return LoginState(
      status: LoginStatus.initial,
      email: '',
      password: '',
      errorMessage: null,
      obscurePassword: true,
    );
  }

  LoginState copyWith({
    LoginStatus? status,
    String? email,
    String? password,
    String? errorMessage,
    bool? obscurePassword,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}
