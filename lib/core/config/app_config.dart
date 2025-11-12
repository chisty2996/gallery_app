/// App configuration class
class AppConfig {
  final String appName;
  final String baseUrl;
  final String flavor;
  final bool enableLogging;

  const AppConfig({
    required this.appName,
    required this.baseUrl,
    required this.flavor,
    this.enableLogging = true,
  });

  bool get isDevelopment => flavor == 'dev';
  bool get isStaging => flavor == 'staging';
  bool get isProduction => flavor == 'prod';
}
