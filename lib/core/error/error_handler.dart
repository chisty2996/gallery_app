import 'dart:io';
import 'package:dio/dio.dart';
import 'package:umbrella_listing/core/error/exceptions.dart';
import 'package:umbrella_listing/core/error/failures.dart';

/// Error handler class to convert exceptions to failures
class ErrorHandler {
  ErrorHandler._();

  /// Convert exception to failure
  static Failure handleException(dynamic exception) {
    if (exception is ServerException) {
      return ServerFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      );
    } else if (exception is CacheException) {
      return CacheFailure(message: exception.message);
    } else if (exception is NetworkException) {
      return const NetworkFailure();
    } else if (exception is AuthException) {
      return AuthFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      );
    } else if (exception is ValidationException) {
      return ValidationFailure(message: exception.message);
    } else if (exception is TimeoutException) {
      return const TimeoutFailure();
    } else if (exception is UnauthorizedException) {
      return const UnauthorizedFailure();
    } else if (exception is NotFoundException) {
      return const NotFoundFailure();
    } else if (exception is BadRequestException) {
      return const BadRequestFailure();
    } else if (exception is InternalServerException) {
      return const InternalServerFailure();
    } else if (exception is DioException) {
      return _handleDioException(exception);
    } else if (exception is SocketException) {
      return const NetworkFailure(
        message: 'No internet connection. Please check your network.',
      );
    } else {
      return UnexpectedFailure(
        message: exception.toString(),
      );
    }
  }

  /// Handle DioException
  static Failure _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure();

      case DioExceptionType.connectionError:
        return const NetworkFailure();

      case DioExceptionType.badResponse:
        return _handleStatusCode(
          exception.response?.statusCode,
          exception.response?.data,
        );

      case DioExceptionType.cancel:
        return const UnexpectedFailure(message: 'Request cancelled');

      case DioExceptionType.unknown:
        if (exception.error is SocketException) {
          return const NetworkFailure();
        }
        return UnexpectedFailure(
          message: exception.message ?? 'An unexpected error occurred',
        );

      default:
        return UnexpectedFailure(
          message: exception.message ?? 'An unexpected error occurred',
        );
    }
  }

  /// Handle HTTP status codes
  static Failure _handleStatusCode(int? statusCode, dynamic responseData) {
    String message = _extractErrorMessage(responseData);

    switch (statusCode) {
      case 400:
        return BadRequestFailure(
          message: message.isEmpty ? 'Bad request' : message,
          statusCode: statusCode,
        );
      case 401:
        return UnauthorizedFailure(
          message: message.isEmpty ? 'Unauthorized access' : message,
          statusCode: statusCode,
        );
      case 403:
        return AuthFailure(
          message: message.isEmpty ? 'Access forbidden' : message,
          statusCode: statusCode,
        );
      case 404:
        return NotFoundFailure(
          message: message.isEmpty ? 'Resource not found' : message,
          statusCode: statusCode,
        );
      case 422:
        return ValidationFailure(
          message: message.isEmpty ? 'Validation error' : message,
        );
      case 500:
      case 502:
      case 503:
        return InternalServerFailure(
          message: message.isEmpty
              ? 'Internal server error. Please try again later.'
              : message,
          statusCode: statusCode,
        );
      default:
        return ServerFailure(
          message: message.isEmpty ? 'Server error occurred' : message,
          statusCode: statusCode,
        );
    }
  }

  /// Extract error message from response data
  static String _extractErrorMessage(dynamic responseData) {
    if (responseData == null) return '';

    try {
      if (responseData is Map) {
        // Try common error message keys
        if (responseData.containsKey('message')) {
          return responseData['message'].toString();
        } else if (responseData.containsKey('error')) {
          var error = responseData['error'];
          if (error is String) {
            return error;
          } else if (error is Map && error.containsKey('message')) {
            return error['message'].toString();
          }
        } else if (responseData.containsKey('errors')) {
          var errors = responseData['errors'];
          if (errors is List && errors.isNotEmpty) {
            return errors.first.toString();
          } else if (errors is Map) {
            return errors.values.first.toString();
          }
        }
      } else if (responseData is String) {
        return responseData;
      }
    } catch (_) {
      return '';
    }

    return '';
  }

  /// Get user-friendly error message
  static String getUserFriendlyMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network and try again.';
    } else if (failure is TimeoutFailure) {
      return 'The request timed out. Please try again.';
    } else if (failure is UnauthorizedFailure) {
      return 'Your session has expired. Please login again.';
    } else if (failure is NotFoundFailure) {
      return 'The requested resource was not found.';
    } else if (failure is InternalServerFailure) {
      return 'Server error. Please try again later.';
    } else {
      return failure.message;
    }
  }
}
