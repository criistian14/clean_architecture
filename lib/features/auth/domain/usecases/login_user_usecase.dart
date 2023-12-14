import 'package:clean_architecture/config/typedef.dart';
import 'package:clean_architecture/config/usecase.dart';
import 'package:clean_architecture/features/auth/domain/entities/user.dart';
import 'package:clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture/features/auth/infrastructure/errors/login_errors.dart';
import 'package:clean_architecture/features/shared/shared.dart';

class LoginUserUseCase extends UseCase<User, LoginParams> {
  const LoginUserUseCase({
    required AuthRepository repository,
    required NativeUtils nativeUtils,
  })  : _repository = repository,
        _nativeUtils = nativeUtils;

  final AuthRepository _repository;
  final NativeUtils _nativeUtils;

  @override
  ResultFuture<User> call(LoginParams params) async {
    // * Se obtiene el uuid del dispositivo
    final deviceUUID = await _nativeUtils.getUUID();
    if (deviceUUID == null) {
      return const Error(
        CustomError(
          "error_uuid_empty",
          shouldTranslate: true,
        ),
      );
    }

    final email = params.email;
    final password = params.password;

    final response = await _repository.login(email, password);

    return response.when(
      (user) async {
        if (user.uuid != deviceUUID) {
          return const Error(LoginWrongUUID());
        }

        await _repository.saveUserCredentials(email, password);

        return Success(user);
      },
      (error) => Error(error),
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
