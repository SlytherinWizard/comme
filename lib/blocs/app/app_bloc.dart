import 'package:comme/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  AppBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AppState.initial()) {
    // on<AuthInitial>(_onAuthInitial);
    // on<AuthLoading>(_onAuthLoading);
    // on<AuthAuthenticated>(_onAuthAuthenticated);
    // on<AuthUnauthenticated>(_onAuthUnauthenticated);
  }
}
