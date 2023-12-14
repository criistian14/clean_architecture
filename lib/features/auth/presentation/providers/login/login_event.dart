part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginPressedButton extends LoginEvent {
  final String email;
  final String password;

  const LoginPressedButton({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class LoginReset extends LoginEvent {
  const LoginReset();

  @override
  List<Object> get props => [];
}

class LoginGetCredentials extends LoginEvent {
  const LoginGetCredentials();

  @override
  List<Object> get props => [];
}
