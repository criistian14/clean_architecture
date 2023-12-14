import 'package:clean_architecture/config/typedef.dart';
import 'package:clean_architecture/features/auth/domain/datasources/auth_datasource.dart';
import 'package:clean_architecture/features/auth/domain/entities/user.dart';
import 'package:clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture/features/shared/shared.dart';

import '../errors/login_errors.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required NetworkInfo networkInfo,
    required AuthLocalDataSource localDataSource,
    required AuthRemoteDataSource remoteDataSource,
  })  : _networkInfo = networkInfo,
        _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  final NetworkInfo _networkInfo;
  final AuthLocalDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<User> login(
    String email,
    String password,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Error(NoConnection());
    }

    try {
      final result = await _remoteDataSource.login(email, password);
      return Success(result);

      // * Errors handling
    } on ConnectionTimeout catch (e) {
      return Error(e);
    } on LoginWrongCredentials catch (e) {
      return Error(e);
    } on CustomError catch (e) {
      return Error(e);
    } catch (e) {
      return Error(
        CustomError(e.toString()),
      );
    }
  }

  @override
  ResultVoid saveUserCredentials(
    String email,
    String password,
  ) async {
    try {
      final result = await _localDataSource.saveUserCredentials(
        email,
        password,
      );

      return Success(result);

      // * Errors handling
    } on CustomError catch (e) {
      return Error(e);
    } catch (e) {
      return Error(
        CustomError(e.toString()),
      );
    }
  }

  @override
  ResultFuture<(String, String)> getCredentials() async {
    try {
      final result = await _localDataSource.getCredentials();

      return Success(result);

      // * Errors handling
    } on CustomError catch (e) {
      return Error(e);
    } catch (e) {
      return Error(
        CustomError(e.toString()),
      );
    }
  }
}
