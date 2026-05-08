import 'package:comme/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthState.initial()) {
    // on<AuthInitial>(_onAuthInitial);
    // on<AuthLoading>(_onAuthLoading);
    // on<AuthAuthenticated>(_onAuthAuthenticated);
    // on<AuthUnauthenticated>(_onAuthUnauthenticated);
  }
}