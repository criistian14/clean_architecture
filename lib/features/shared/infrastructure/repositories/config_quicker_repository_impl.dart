import 'package:clean_architecture/config/typedef.dart';
import 'package:clean_architecture/features/shared/domain/datasources/config_quicker_datasource.dart';
import 'package:clean_architecture/features/shared/domain/repositories/config_quicker_repository.dart';
import 'package:clean_architecture/features/shared/shared.dart';

class ConfigQuickerRepositoryImpl implements ConfigQuickerRepository {
  ConfigQuickerRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final ConfigQuickerRemoteDataSource remoteDataSource;
  final ConfigQuickerLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<Map<String, dynamic>> getAllRemoteConfig() async {
    try {
      Map<String, dynamic> config = await localDataSource.getAllRemoteConfig();

      if (await networkInfo.isConnected) {
        final configRemote = await remoteDataSource.getAllRemoteConfig();
        if (configRemote.isNotEmpty) {
          config = configRemote;
        }
      }

      return Success(config);
    } catch (e) {
      return Error(CustomError(e.toString()));
    }
  }

  @override
  ResultFuture<Map<String, dynamic>> getUserConfig() {
    // TODO: implement getUserConfig
    throw UnimplementedError();
  }
}
