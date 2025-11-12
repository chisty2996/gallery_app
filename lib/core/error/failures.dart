import 'package:equatable/equatable.dart';

/// Base failure class
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];

  @override
  String toString() => message;
}

/// Server failure
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

/// Cache failure
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

/// Network failure
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection. Please check your network.',
  });
}

/// Authentication failure
class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.statusCode});
}

/// Validation failure
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}

/// Timeout failure
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'Request timeout. Please try again.',
  });
}

/// Unauthorized failure
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Unauthorized access. Please login again.',
    super.statusCode = 401,
  });
}

/// Not found failure
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'Resource not found.',
    super.statusCode = 404,
  });
}

/// Bad request failure
class BadRequestFailure extends Failure {
  const BadRequestFailure({
    super.message = 'Bad request.',
    super.statusCode = 400,
  });
}

/// Internal server failure
class InternalServerFailure extends Failure {
  const InternalServerFailure({
    super.message = 'Internal server error. Please try again later.',
    super.statusCode = 500,
  });
}

/// Unexpected failure
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'An unexpected error occurred. Please try again.',
  });
}
