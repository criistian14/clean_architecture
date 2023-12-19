import 'package:clean_architecture/config/typedef.dart';

abstract class ConfigQuickerRepository {
  ResultFuture<Map<String, dynamic>> getAllRemoteConfig();

  ResultFuture<Map<String, dynamic>> getUserConfig();
}
