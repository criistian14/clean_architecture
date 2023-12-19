abstract class ConfigQuickerRemoteDataSource {
  const ConfigQuickerRemoteDataSource();

  Future<Map<String, dynamic>> getAllRemoteConfig();

  Future<Map<String, dynamic>> getUserConfig();
}

abstract class ConfigQuickerLocalDataSource {
  const ConfigQuickerLocalDataSource();

  Future<Map<String, dynamic>> getAllRemoteConfig();

  Future<void> saveAllRemoteConfig(Map<String, dynamic> config);

  Future<Map<String, dynamic>> getUserConfig();

  Future<void> saveUserConfig(Map<String, dynamic> config);
}
