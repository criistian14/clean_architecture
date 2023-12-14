import 'package:clean_architecture/config/base_errors.dart';

class NoConnection implements ErrorSnackbarBase {
  const NoConnection();
}

class ConnectionTimeout implements ErrorSnackbarBase {
  const ConnectionTimeout({
    this.time = 50,
  });

  final int time;
}
