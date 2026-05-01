

import 'package:comme_flutter/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthState.unauthenticated()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
  }

  void _onAuthStatusChanged(AuthStatusChanged event, Emitter<AuthState> emit) {
    switch (event.status) {
      case AuthStatus.authenticated:
        emit(AuthState.authenticated());
        break;
      case AuthStatus.unauthenticated:
        emit(AuthState.unauthenticated());
        break;
    }
  }
}
