import 'package:auto_route/auto_route.dart';
import 'package:umbrella_listing/core/storage/secure_storage_service.dart';

/// Auth guard to protect authenticated routes
class AuthGuard extends AutoRouteGuard {
  final SecureStorageService _secureStorage;

  AuthGuard(this._secureStorage);

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    // Check if user is authenticated
    final token = await _secureStorage.getAccessToken();
    final isAuthenticated = token != null && token.isNotEmpty;

    if (isAuthenticated) {
      // User is authenticated, allow navigation
      resolver.next(true);
    } else {
      // User is not authenticated, redirect to login
      resolver.next(false);
      // TODO: Navigate to login route when implemented
      // router.push(const LoginRoute());
    }
  }
}
