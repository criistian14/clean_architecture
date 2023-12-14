import 'package:clean_architecture/config/base_errors.dart';

class CustomError implements ErrorSnackbarBase {
  final String message;

  const CustomError(this.message);
}
