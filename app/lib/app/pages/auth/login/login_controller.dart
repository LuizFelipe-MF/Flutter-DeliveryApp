import 'package:app/app/core/exeptions/unauthorized_exeption.dart';
import 'package:app/app/pages/auth/login/login_state.dart';
import 'package:app/app/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController(this._authRepository)
      : super(
          const LoginState.initial(),
        );

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      final authModel = await _authRepository.login(email, password);
      final sp = await SharedPreferences.getInstance();

      sp.setString('accessToken', authModel.accessToken);
      sp.setString('RefreshToken', authModel.refreshToken);
      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedExeption catch (e) {
      emit(
        state.copyWith(
            status: LoginStatus.loginError,
            errorMessage: 'E-mail ou senha inválidos.'),
      );
    } catch (e) {
      emit(state.copyWith(
          status: LoginStatus.error, errorMessage: 'Erro ao realizar login.'));
    }
  }
}
