part of 'app_bloc.dart';

abstract class AppEvent {}

class AppInitialized extends AppEvent {}

class AppSignUpRequested extends AppEvent {
  final String email;
  final String password;
  final String displayName;

  AppSignUpRequested({
    required this.email,
    required this.password,
    required this.displayName,
  });
}

class AppSignInRequested extends AppEvent {
  final String email;
  final String password;

  AppSignInRequested({required this.email, required this.password});
}

class AppSignOutRequested extends AppEvent {}

class AppAuthStateChanged extends AppEvent {}

class AppUserUpdated extends AppEvent {}
