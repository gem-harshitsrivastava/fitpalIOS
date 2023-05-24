class AppConfig {
  final String apiUrl;
  final String appName;
  AppConfig({required this.apiUrl, required this.appName});
}

class DevConfig extends AppConfig {
  DevConfig() : super(apiUrl: 'http://localhost:4200/', appName: 'Dev App');
}

class ProdConfig extends AppConfig {
  ProdConfig() : super(apiUrl: 'http://gem-fit.com', appName: 'Prod App');
}
