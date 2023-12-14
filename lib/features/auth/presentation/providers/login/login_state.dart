part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

@CopyWith()
class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.error,
  });

  final LoginStatus status;
  final Exception? error;

  @override
  List<Object?> get props => [
        status,
        error,
      ];
}
