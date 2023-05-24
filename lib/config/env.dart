import 'package:gem_fitpal/config/app_config.dart';

enum Environment { dev, prod }

abstract class AppEnvironment {
  static late AppConfig appConfig;

  static void setupEnv(Environment env) {
    switch (env) {
      case Environment.prod:
        {
          appConfig = ProdConfig();
          break;
        }
      case Environment.dev:
        {
          appConfig = DevConfig();
          break;
        }
    }
  }
}
