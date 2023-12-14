import 'package:clean_architecture/features/auth/domain/datasources/auth_datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<bool> saveUserCredentials(String email, String password) async {
    // Guardar en hive or secure preferences
    return true;
  }

  @override
  Future<String> getToken() async {
    // Consultar del hive or secure preferences
    return "token";
  }
}
