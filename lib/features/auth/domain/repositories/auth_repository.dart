import 'package:clean_architecture/config/typedef.dart';

import '../entities/user.dart';

mixin AuthRepository {
  ResultFuture<User> login(String email, String password);

  ResultVoid saveUserCredentials(
    String email,
    String password,
  );

  ResultFuture<(String, String)> getCredentials();
}
