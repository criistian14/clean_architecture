import 'package:clean_architecture/features/auth/auth.dart';
import 'package:clean_architecture/features/shared/shared.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

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

  //! Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
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

  //! Libraries
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton<HiveInterface>(() => Hive);

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
