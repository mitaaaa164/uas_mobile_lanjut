class EnvConfig {
  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'DEV',
  );

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://newsapi.org/v2/',
  );

  static bool get isProduction => environment == 'PROD';
  static String get appName => isProduction ? 'UTD - 20123051' : 'DEV - Mita';
}