import 'package:clean_architecture/features/auth/auth.dart';
import 'package:clean_architecture/features/shared/shared.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Providers
  _initBlocs();

  //! Use cases
  sl.registerLazySingleton(
    () => LoginUserUseCase(
      repository: sl(),
      nativeUtils: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetCredentialsUserUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => LoadRemoteConfigUseCase(repository: sl()),
  );

  //! Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ConfigQuickerRepository>(
    () => ConfigQuickerRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  //! Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      hiveBox: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<ConfigQuickerLocalDataSource>(
    () => ConfigQuickerLocalDataSourceImpl(
      box: sl(),
    ),
  );
  sl.registerLazySingleton<ConfigQuickerRemoteDataSource>(
    () => ConfigQuickerRemoteDataSourceImpl(),
  );

  //! Libraries
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton<HiveInterface>(() => Hive);
  sl.registerLazySingleton(() => http.Client());

  //! Helpers
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(),
  );
  sl.registerLazySingleton(
    () => HiveBoxService(
      secureStorage: sl(),
      hive: sl(),
    ),
  );
  sl.registerLazySingleton(() => NativeUtils());

  //! Hive
  final hiveBoxService = sl<HiveBoxService>();
  final authBox = await hiveBoxService.openEncryptedBox('auth');

  sl.registerLazySingleton<Box>(() => authBox);
}

void _initBlocs() {
  sl.registerFactory(
    () => ErrorWrapperCubit(),
  );

  sl.registerFactory(
    () => LoginBloc(
      loginUserUseCase: sl(),
      getCredentialsUserUseCase: sl(),
    ),
  );
}
