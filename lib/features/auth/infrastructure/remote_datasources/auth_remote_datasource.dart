import 'package:clean_architecture/features/auth/domain/datasources/auth_datasource.dart';
import 'package:clean_architecture/features/auth/domain/entities/user.dart';
import 'package:clean_architecture/features/auth/infrastructure/errors/login_errors.dart';
import 'package:clean_architecture/features/auth/infrastructure/models/user_model.dart';
import 'package:clean_architecture/features/shared/shared.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<User> login(
    String email,
    String password,
  ) async {
    try {
      // * Se hace la peticion
      await Future.delayed(const Duration(milliseconds: 1500));

      if (email != "test@test.com" || password != "123") {
        throw const LoginWrongCredentials();
      }

      final response = {
        'code': 200,
        'user': {
          'id': 1,
          'name': 'John Doe',
          'email': 'john@doe.com',
          'token': '1234567890',
          'uuid': '1234567890',
        },
      };

      if (response['code'] == 444 || response['code'] == 500) {
        throw const ConnectionTimeout();
      }

      if (response['code'] != 200) {
        throw const LoginWrongCredentials();
      }

      final data = response['user'] as Map<String, dynamic>;
      final user = UserModel.fromJson(data);

      return user;

      // * Errors handling
    } on ConnectionTimeout catch (_) {
      rethrow;
    } on LoginWrongCredentials catch (_) {
      rethrow;
    } catch (e) {
      throw CustomError(e.toString());
    }
  }
}
