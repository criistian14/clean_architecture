import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'login_bloc.g.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginUserUseCase loginUserUseCase,
  })  : _loginUserUseCase = loginUserUseCase,
        super(const LoginState()) {
    on<LoginPressedButton>(_onLoginPressedButton);
  }

  final LoginUserUseCase _loginUserUseCase;

  Future<void> _onLoginPressedButton(
    LoginPressedButton event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status == LoginStatus.loading) return;
    emit(state.copyWith(status: LoginStatus.loading, error: null));

    // * Se obtiene el uuid del dispositivo
    // const uuid = "1234";
    const uuid = "1234567890";

    // * Se hace la peticion
    final loginUserCall = await _loginUserUseCase(
      LoginParams(
        email: event.email,
        password: event.password,
        uuid: uuid,
      ),
    );

    loginUserCall.when(
      (success) {
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
}
