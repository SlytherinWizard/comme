part of 'signup_cubit.dart';

enum SignupStatus { initial, loading, success }

class SignupState {
  final SignupStatus status;
  final String email;
  final String password;

  SignupState({
    required this.status,
    required this.email,
    required this.password,
  });

  factory SignupState.initial() {
    return SignupState(status: SignupStatus.initial, email: '', password: '');
  }

  SignupState copyWith({
    SignupStatus? status,
    String? email,
    String? password,
  }) {
    return SignupState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
