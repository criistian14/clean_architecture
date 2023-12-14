import 'package:clean_architecture/features/auth/domain/entities/user.dart';

mixin AuthRemoteDataSource {
  Future<User> login(String email, String password);
}

mixin AuthLocalDataSource {
  Future<bool> saveUserCredentials(String email, String password);
  Future<String> getToken();
}
