import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture/config/usecase.dart';
import 'package:clean_architecture/features/auth/domain/usecases/get_credentials_user_usecase.dart';
import 'package:clean_architecture/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:talker/talker.dart';

part 'login_bloc.g.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginUserUseCase loginUserUseCase,
    required GetCredentialsUserUseCase getCredentialsUserUseCase,
  })  : _loginUserUseCase = loginUserUseCase,
        _getCredentialsUserUseCase = getCredentialsUserUseCase,
        super(const LoginState()) {
    on<LoginPressedButton>(_onLoginPressedButton);
    on<LoginReset>(_onLoginReset);
    on<LoginGetCredentials>(_onLoginGetCredentials);
  }

  final LoginUserUseCase _loginUserUseCase;
  final GetCredentialsUserUseCase _getCredentialsUserUseCase;

  Future<void> _onLoginPressedButton(
    LoginPressedButton event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status == LoginStatus.loading) return;
    emit(state.copyWith(status: LoginStatus.loading, error: null));

    // * Se hace la peticion
    final loginUserCall = await _loginUserUseCase(
      LoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    loginUserCall.when(
      (user) {
        Talker().good(user);

        emit(state.copyWith(status: LoginStatus.success, error: null));
      },
      (error) {
        emit(state.copyWith(
          status: LoginStatus.failure,
          error: error,
        ));
      },
    );
  }

  Future<void> _onLoginReset(LoginReset event, Emitter<LoginState> emit) async {
    emit(const LoginState());
  }

  Future<void> _onLoginGetCredentials(
    LoginGetCredentials event,
    Emitter<LoginState> emit,
  ) async {
    final getCredentialsUserCall = await _getCredentialsUserUseCase(NoParams());

    getCredentialsUserCall.when(
      (success) {
        final (email, password) = success;

        Talker().good("Email: $email - Password: $password");
      },
      (error) {
        emit(state.copyWith(
          status: LoginStatus.failure,
          error: error,
        ));
      },
    );
  }
}
