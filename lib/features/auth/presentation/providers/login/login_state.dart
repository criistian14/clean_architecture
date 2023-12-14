part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

@CopyWith()
class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.error,
    this.emailSaved,
    this.passwordSaved,
  });

  final LoginStatus status;
  final Exception? error;

  final String? emailSaved;
  final String? passwordSaved;

  @override
  List<Object?> get props => [
        status,
        error,
        emailSaved,
        passwordSaved,
      ];
}
