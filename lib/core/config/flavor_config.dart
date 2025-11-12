import 'package:umbrella_listing/core/config/app_config.dart';
import 'package:umbrella_listing/core/network/api_endpoints.dart';

/// Flavor configuration class
class FlavorConfig {
  static AppConfig? _config;

  static AppConfig get config {
    if (_config == null) {
      throw Exception('FlavorConfig not initialized');
    }
    return _config!;
  }

  static void initialize(AppConfig config) {
    _config = config;
  }

  /// Development configuration
  static AppConfig get development => const AppConfig(
        appName: 'Umbrella Listing Dev',
        baseUrl: ApiEndpoints.devBaseUrl,
        flavor: 'dev',
        enableLogging: true,
      );

  /// Staging configuration
  static AppConfig get staging => const AppConfig(
        appName: 'Umbrella Listing Staging',
        baseUrl: ApiEndpoints.stagingBaseUrl,
        flavor: 'staging',
        enableLogging: true,
      );

  /// Production configuration
  static AppConfig get production => const AppConfig(
        appName: 'Umbrella Listing',
        baseUrl: ApiEndpoints.prodBaseUrl,
        flavor: 'prod',
        enableLogging: false,
      );
}
