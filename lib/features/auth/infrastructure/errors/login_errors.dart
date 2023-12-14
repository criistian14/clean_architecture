import 'package:clean_architecture/config/base_errors.dart';

class LoginWrongCredentials implements ErrorSnackbarBase {
  const LoginWrongCredentials();
}

class LoginInvalidToken implements ErrorRetryBase {
  const LoginInvalidToken();
}

class LoginWrongUUID implements ErrorRetryBase {
  const LoginWrongUUID();
}
