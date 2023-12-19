enum Environment { qa, production, develop, replica }

class Persist {
  static const Environment environment = Environment.qa;

  static Map<String, dynamic> remoteConfigQuicker = {};

  ///Base to call endpoints accord to environment.
  static String get url {
    switch (environment) {
      case Environment.qa:
        return remoteConfigQuicker["url_dev"];
      case Environment.develop:
        return remoteConfigQuicker["url_develop"];
      case Environment.replica:
        return remoteConfigQuicker["url_replica"];
      case Environment.production:
        return remoteConfigQuicker["url_prod"];
      default:
        return remoteConfigQuicker["url_dev"];
    }
  }

  static String get appName => remoteConfigQuicker["app_name"];
}
