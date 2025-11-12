import 'package:dio/dio.dart';
import 'package:umbrella_listing/core/storage/secure_storage_service.dart';

/// Auth interceptor to add authentication token to requests
class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorage;

  AuthInterceptor(this._secureStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get access token from secure storage
    final token = await _secureStorage.getAccessToken();

    // Add token to headers if available
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Add guest ID if available (for guest users)
    final guestId = await _secureStorage.getGuestId();
    if (guestId != null && guestId.isNotEmpty) {
      options.headers['X-Guest-ID'] = guestId;
    }

    // Continue with the request
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 Unauthorized - token might be expired
    if (err.response?.statusCode == 401) {
      // TODO: Implement token refresh logic here
      // For now, just pass the error
    }

    handler.next(err);
  }
}
