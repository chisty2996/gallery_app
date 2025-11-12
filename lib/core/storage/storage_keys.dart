/// Storage keys for consistent key usage across the app
class StorageKeys {
  StorageKeys._();

  // Authentication Keys
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String isLoggedIn = 'is_logged_in';
  static const String isGuest = 'is_guest';
  static const String guestId = 'guest_id';

  // User Profile Keys
  static const String userProfile = 'user_profile';
  static const String userName = 'user_name';
  static const String userRole = 'user_role';
  static const String userPhone = 'user_phone';

  // Settings Keys
  static const String themeMode = 'theme_mode';
  static const String languageCode = 'language_code';
  static const String notificationsEnabled = 'notifications_enabled';

  // Onboarding Keys
  static const String isOnboardingCompleted = 'is_onboarding_completed';

  // Session Keys
  static const String lastActiveTime = 'last_active_time';
  static const String sessionId = 'session_id';

  // Cache Keys
  static const String apiCachePrefix = 'api_cache_';

  // Biometric Keys
  static const String biometricEnabled = 'biometric_enabled';
  static const String biometricCredentials = 'biometric_credentials';

  // FCM Keys
  static const String fcmToken = 'fcm_token';
}
