part of 'auth_bloc.dart';

enum AuthStage { authenticated, unauthenticated }

class AuthState {
  final AuthStage stage;

  AuthState({required this.stage});

  factory AuthState.initial() {
    return AuthState(stage: AuthStage.unauthenticated);
  }

  AuthState copyWith({AuthStage? stage}) {
    return AuthState(stage: stage ?? this.stage);
  }
}
