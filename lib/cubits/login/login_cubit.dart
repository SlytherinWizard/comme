import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  /// Update email field
  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  /// Update password field
  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  /// Clear form
  void clearForm() {
    emit(LoginState.initial());
  }

  /// Validate email and password
  bool isFormValid() {
    return state.email.isNotEmpty &&
        state.password.isNotEmpty &&
        _isValidEmail(state.email);
  }

  /// Email validation helper
  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }
}
