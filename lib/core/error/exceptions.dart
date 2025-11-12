/// Base exception class
class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

/// Server exception
class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode});
}

/// Cache exception
class CacheException extends AppException {
  const CacheException({required super.message});
}

/// Network exception
class NetworkException extends AppException {
  const NetworkException({required super.message});
}

/// Authentication exception
class AuthException extends AppException {
  const AuthException({required super.message, super.statusCode});
}

/// Validation exception
class ValidationException extends AppException {
  const ValidationException({required super.message});
}

/// Timeout exception
class TimeoutException extends AppException {
  const TimeoutException({required super.message});
}

/// Unauthorized exception
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Unauthorized access',
    super.statusCode = 401,
  });
}

/// Not found exception
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Resource not found',
    super.statusCode = 404,
  });
}

/// Bad request exception
class BadRequestException extends AppException {
  const BadRequestException({
    super.message = 'Bad request',
    super.statusCode = 400,
  });
}

/// Internal server error exception
class InternalServerException extends AppException {
  const InternalServerException({
    super.message = 'Internal server error',
    super.statusCode = 500,
  });
}
