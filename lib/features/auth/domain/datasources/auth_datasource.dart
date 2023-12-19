import 'package:clean_architecture/features/auth/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(String email, String password);
}

abstract class AuthLocalDataSource {
  Future<void> saveUserCredentials(String email, String password);
  Future<(String, String)> getCredentials();
}
