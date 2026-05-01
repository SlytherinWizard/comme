part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;

  AuthState({required this.status});

  factory AuthState.authenticated() {
    return AuthState(status: AuthStatus.authenticated);
  }

  factory AuthState.unauthenticated() {
    return AuthState(status: AuthStatus.unauthenticated);
  }
}
