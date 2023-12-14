import 'package:bloc/bloc.dart';

class ErrorWrapperCubit extends Cubit<Exception?> {
  ErrorWrapperCubit() : super(null);

  void showError(Exception error) => emit(error);

  void hideError() => emit(null);
}
