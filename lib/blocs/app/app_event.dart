part of 'app_bloc.dart';

class AppEvent {}

class AppInitial extends AppEvent {}

class AppLoading extends AppEvent {}

class AppUserAuthenticated extends AppEvent {
  final String userId;

  AppUserAuthenticated(this.userId);
}

class AppUserUnauthenticated extends AppEvent {}
