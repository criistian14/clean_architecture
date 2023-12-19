import 'package:clean_architecture/features/shared/domain/datasources/config_quicker_datasource.dart';

class ConfigQuickerRemoteDataSourceImpl extends ConfigQuickerRemoteDataSource {
  @override
  Future<Map<String, dynamic>> getAllRemoteConfig() async {
    // Get All Remote Config from Firebase
    await Future.delayed(const Duration(milliseconds: 1500));

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
}
