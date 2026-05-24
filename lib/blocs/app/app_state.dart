part of 'app_bloc.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AppState {
  final AuthStatus authStatus;
  final UserModel? user;
  final String? errorMessage;
  final bool isEmailVerified;

  AppState({
    required this.authStatus,
    this.user,
    this.errorMessage,
    this.isEmailVerified = false,
  });

  factory AppState.initial() {
    return AppState(
      authStatus: AuthStatus.initial,
      user: null,
      errorMessage: null,
      isEmailVerified: false,
    );
  }

  AppState copyWith({
    AuthStatus? authStatus,
    UserModel? user,
    String? errorMessage,
    bool? isEmailVerified,
  }) {
    return AppState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }
}
