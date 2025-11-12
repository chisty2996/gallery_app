/// API endpoints for the app
class ApiEndpoints {
  ApiEndpoints._();

  // Base URLs
  static const String devBaseUrl = 'https://api-dev.umbrella.com';
  static const String stagingBaseUrl = 'https://api-staging.umbrella.com';
  static const String prodBaseUrl = 'https://api.umbrella.com';

  // Authentication Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String guestUser = '/auth/guest';

  // User Endpoints
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';
  static const String changePassword = '/user/change-password';

  // Listing Endpoints
  static const String listings = '/listings';
  static const String listingDetails = '/listings/{id}';
  static const String createListing = '/listings/create';
  static const String updateListing = '/listings/{id}/update';
  static const String deleteListing = '/listings/{id}/delete';

  // Search Endpoints
  static const String search = '/search';
  static const String searchFilters = '/search/filters';

  // Favorites Endpoints
  static const String favorites = '/favorites';
  static const String addFavorite = '/favorites/add';
  static const String removeFavorite = '/favorites/{id}/remove';

  // Helper method to replace path parameters
  static String replacePathParams(String path, Map<String, String> params) {
    String result = path;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value);
    });
    return result;
  }
}
