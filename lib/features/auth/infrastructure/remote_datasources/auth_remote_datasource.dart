import 'dart:convert';

import 'package:clean_architecture/features/auth/domain/datasources/auth_datasource.dart';
import 'package:clean_architecture/features/auth/domain/entities/user.dart';
import 'package:clean_architecture/features/auth/infrastructure/errors/login_errors.dart';
import 'package:clean_architecture/features/auth/infrastructure/models/user_model.dart';
import 'package:clean_architecture/features/shared/shared.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource
    with HttpClientMixin {
  @override
  Future<User> login(
    String email,
    String password,
  ) async {
    Response response;

    try {
      final endpoint = Uri.parse("$baseUrl/auth/login");
      response = await client.get(endpoint);
    } catch (_) {}

    // !  ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ Esto solo pruebas ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
    response = Response(
      jsonEncode({
        'id': 1,
        'name': 'John Doe',
        'email': 'john@doe.com',
        'token': '1234567890',
        'uuid': '1234567890',
      }),
      200,
    );
    await Future.delayed(const Duration(milliseconds: 1500));
    if (email != "test@test.com" || password != "123") {
      throw const LoginWrongCredentials();
    }
    // !  ↑↑↑↑↑↑↑↑↑↑↑↑↑↑  Esto solo pruebas  ↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    final (code, responseFormat) = request(response);

    if (code == 444 || code == 500) {
      throw const ConnectionTimeout();
    }

    if (responseFormat['error'] != null) {
      final error = responseFormat['error'].toString();

      if (error.contains("credentials")) {
        throw const LoginWrongCredentials();
      }

      throw CustomError(error);
    }

    Map<String, dynamic> data = responseFormat['get'] as Map<String, dynamic>;
    final user = UserModel.fromJson(data);

    return user;
  }
}
