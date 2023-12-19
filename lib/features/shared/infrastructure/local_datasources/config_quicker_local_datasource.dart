import 'package:clean_architecture/features/shared/domain/datasources/config_quicker_datasource.dart';
import 'package:hive/hive.dart';

class ConfigQuickerLocalDataSourceImpl implements ConfigQuickerLocalDataSource {
  const ConfigQuickerLocalDataSourceImpl({required this.box});

  final Box box;

  @override
  Future<Map<String, dynamic>> getAllRemoteConfig() async {
    // Get All Remote Config from Box Hive
    await Future.delayed(const Duration(milliseconds: 1500));

    // If hive is empty load from file

    return {
      'app_name': 'Clean Architecture',
      'app_version': '1.0.0',
      'app_environment': 'development',
      'url_dev': 'https://api.clean-architecture.com',
      'api_key': '1234567890',
    };
  }

  @override
  Future<Map<String, dynamic>> getUserConfig() {
    // TODO: implement getUserConfig
    throw UnimplementedError();
  }

  @override
  Future<void> saveAllRemoteConfig(Map<String, dynamic> config) {
    // TODO: implement saveAllRemoteConfig
    throw UnimplementedError();
  }

  @override
  Future<void> saveUserConfig(Map<String, dynamic> config) {
    // TODO: implement saveUserConfig
    throw UnimplementedError();
  }
}
