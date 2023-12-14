import 'package:clean_architecture/features/auth/domain/datasources/auth_datasource.dart';
import 'package:clean_architecture/features/shared/infrastructure/errors/default_errors.dart';
import 'package:hive/hive.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl({
    required Box hiveBox,
  }) : _hiveBox = hiveBox;

  final Box _hiveBox;

  @override
  Future<void> saveUserCredentials(String email, String password) async {
    await _hiveBox.put('email', email);
    await _hiveBox.put('password', password);
  }

  @override
  Future<(String, String)> getCredentials() async {
    final email = _hiveBox.get('email') as String?;
    final password = _hiveBox.get('password') as String?;

    if (email == null || password == null) {
      throw const CustomError("No hay credenciales guardadas");
    }

    return (email, password);
  }
}
