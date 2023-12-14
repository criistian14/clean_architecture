import 'package:equatable/equatable.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class UseCase<Type, Params> {
  const UseCase();

  Future<Result<Type, Exception>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
