import 'package:clean_architecture/config/usecase.dart';
import 'package:clean_architecture/features/auth/domain/entities/user.dart';
import 'package:clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture/features/auth/infrastructure/errors/login_errors.dart';
import 'package:multiple_result/multiple_result.dart';

class LoginUserUseCase extends UseCase<User, LoginParams> {
  const LoginUserUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Future<Result<User, Exception>> call(LoginParams params) async {
    final email = params.email;
    final password = params.password;
    final deviceUUID = params.uuid;

    final response = await _authRepository.login(email, password);

    return response.when(
      (user) async {
        if (user.uuid != deviceUUID) {
          return const Error(LoginWrongUUID());
        }

        await _authRepository.saveUserCredentials(email, password);

        return Success(user);
      },
      (error) => Error(error),
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  final String uuid;

  LoginParams({
    required this.email,
    required this.password,
    required this.uuid,
  });
}
