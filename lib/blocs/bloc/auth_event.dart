part of 'auth_bloc.dart';


class AuthEvent {}

class AuthInitial extends AuthEvent {}

class AuthLoading extends AuthEvent {}

class AuthAuthenticated extends AuthEvent {
  final String userId;

  AuthAuthenticated(this.userId);
}

class AuthUnauthenticated extends AuthEvent {}