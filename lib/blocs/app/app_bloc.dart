import 'package:comme/models/auth_exception.dart';
import 'package:comme/models/user_model.dart';
import 'package:comme/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;

  AppBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AppState.initial()) {
    on<AppInitialized>(_onAppInitialized);
    on<AppSignUpRequested>(_onSignUpRequested);
    on<AppSignInRequested>(_onSignInRequested);
    on<AppSignOutRequested>(_onSignOutRequested);
    on<AppAuthStateChanged>(_onAuthStateChanged);
    on<AppUserUpdated>(_onUserUpdated);
  }

  /// Initialize the app and check current auth state
  Future<void> _onAppInitialized(
    AppInitialized event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(state.copyWith(authStatus: AuthStatus.loading));

      // Listen to auth state changes
      _authRepository.authStateChanges.listen((_) {
        add(AppAuthStateChanged());
      });

      // Check if user is already authenticated
      if (_authRepository.isAuthenticated) {
        final userModel = await _authRepository.getCurrentUserModel();
        if (userModel != null) {
          emit(
            state.copyWith(
              authStatus: AuthStatus.authenticated,
              user: userModel,
            ),
          );
        } else {
          emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
        }
      } else {
        emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
      }
    } on AuthException catch (e) {
      emit(
        state.copyWith(authStatus: AuthStatus.error, errorMessage: e.message),
      );
    }
  }

  /// Handle sign up
  Future<void> _onSignUpRequested(
    AppSignUpRequested event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(state.copyWith(authStatus: AuthStatus.loading));

      final userModel = await _authRepository.signUpWithEmail(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
      );

      emit(
        state.copyWith(
          authStatus: AuthStatus.authenticated,
          user: userModel,
          errorMessage: null,
        ),
      );
    } on AuthException catch (e) {
      emit(
        state.copyWith(authStatus: AuthStatus.error, errorMessage: e.message),
      );
    }
  }

  /// Handle sign in
  Future<void> _onSignInRequested(
    AppSignInRequested event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(state.copyWith(authStatus: AuthStatus.loading));

      final userModel = await _authRepository.signInWithEmail(
        email: event.email,
        password: event.password,
      );

      emit(
        state.copyWith(
          authStatus: AuthStatus.authenticated,
          user: userModel,
          errorMessage: null,
        ),
      );
    } on AuthException catch (e) {
      emit(
        state.copyWith(authStatus: AuthStatus.error, errorMessage: e.message),
      );
    }
  }

  /// Handle sign out
  Future<void> _onSignOutRequested(
    AppSignOutRequested event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(state.copyWith(authStatus: AuthStatus.loading));
      await _authRepository.signOut();
      emit(
        state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          errorMessage: null,
        ),
      );
    } on AuthException catch (e) {
      emit(
        state.copyWith(authStatus: AuthStatus.error, errorMessage: e.message),
      );
    }
  }

  /// Handle auth state changes
  Future<void> _onAuthStateChanged(
    AppAuthStateChanged event,
    Emitter<AppState> emit,
  ) async {
    try {
      if (_authRepository.isAuthenticated) {
        final userModel = await _authRepository.getCurrentUserModel();
        if (userModel != null) {
          emit(
            state.copyWith(
              authStatus: AuthStatus.authenticated,
              user: userModel,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(authStatus: AuthStatus.unauthenticated, user: null),
        );
      }
    } on AuthException catch (e) {
      emit(
        state.copyWith(authStatus: AuthStatus.error, errorMessage: e.message),
      );
    }
  }

  /// Handle user update
  Future<void> _onUserUpdated(
    AppUserUpdated event,
    Emitter<AppState> emit,
  ) async {
    try {
      final userModel = await _authRepository.getCurrentUserModel();
      if (userModel != null) {
        emit(state.copyWith(user: userModel));
      }
    } on AuthException catch (e) {
      emit(
        state.copyWith(authStatus: AuthStatus.error, errorMessage: e.message),
      );
    }
  }
}
