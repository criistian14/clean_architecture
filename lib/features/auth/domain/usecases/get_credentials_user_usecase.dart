import 'package:clean_architecture/config/typedef.dart';
import 'package:clean_architecture/config/usecase.dart';
import 'package:clean_architecture/features/auth/auth.dart';

class GetCredentialsUserUseCase extends UseCase<(String, String), NoParams> {
  const GetCredentialsUserUseCase({
    required AuthRepository repository,
  }) : _repository = repository;

  final AuthRepository _repository;

  @override
  ResultFuture<(String, String)> call(NoParams params) async {
    return await _repository.getCredentials();
  }
}
