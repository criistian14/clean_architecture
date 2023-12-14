import 'package:clean_architecture/config/base_errors.dart';
import 'package:equatable/equatable.dart';

class CustomError extends Equatable implements ErrorSnackbarBase {
  final String message;
  final bool shouldTranslate;

  const CustomError(
    this.message, {
    this.shouldTranslate = false,
  });

  @override
  List<Object?> get props => [
        message,
        shouldTranslate,
      ];
}
