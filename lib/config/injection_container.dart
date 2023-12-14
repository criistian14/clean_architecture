import 'package:clean_architecture/features/auth/auth.dart';
import 'package:clean_architecture/features/shared/helpers/network_info.dart';
import 'package:clean_architecture/features/shared/providers/error_wrapper_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Providers
  _initBlocs();

  //! Use cases
  sl.registerLazySingleton(
    () => LoginUserUseCase(authRepository: sl()),
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
    () => AuthLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  //! Libraries

  //! Helpers
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(),
  );
}

void _initBlocs() {
  sl.registerFactory(
    () => ErrorWrapperCubit(),
  );

  sl.registerFactory(
    () => LoginBloc(loginUserUseCase: sl()),
  );
}
