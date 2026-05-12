part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success }

class LoginState {
  final LoginStatus status;
  final String email;
  final String password;

  LoginState({
    required this.status,
    required this.email,
    required this.password,
  });

  factory LoginState.initial() {
    return LoginState(status: LoginStatus.initial, email: '', password: '');
  }

  LoginState copyWith({LoginStatus? status, String? email, String? password}) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
