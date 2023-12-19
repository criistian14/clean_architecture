import 'package:clean_architecture/config/persist.dart';
import 'package:clean_architecture/config/typedef.dart';
import 'package:clean_architecture/config/usecase.dart';
import 'package:clean_architecture/features/shared/domain/repositories/config_quicker_repository.dart';

class LoadRemoteConfigUseCase extends UseCase<void, NoParams> {
  const LoadRemoteConfigUseCase({required this.repository});

  final ConfigQuickerRepository repository;

  @override
  ResultFuture<void> call(NoParams params) async {
    final config = await repository.getAllRemoteConfig();
    return config.when(
      (data) {
        Persist.remoteConfigQuicker = data;
        return const Success(null);
      },
      (error) => Error(error),
    );
  }
}
