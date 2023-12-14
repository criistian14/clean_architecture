import 'package:multiple_result/multiple_result.dart';

import '../entities/user.dart';

mixin AuthRepository {
  Future<Result<User, Exception>> login(String email, String password);
  Future<Result<bool, Exception>> saveUserCredentials(
    String email,
    String password,
  );
}
