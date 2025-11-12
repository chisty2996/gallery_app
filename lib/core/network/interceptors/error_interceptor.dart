import 'package:dio/dio.dart';
import 'package:umbrella_listing/core/error/exceptions.dart';

/// Error interceptor to handle and transform errors
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppException exception;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        exception = const TimeoutException(
          message: 'Request timeout. Please try again.',
        );
        break;

      case DioExceptionType.connectionError:
        exception = const NetworkException(
          message: 'No internet connection. Please check your network.',
        );
        break;

      case DioExceptionType.badResponse:
        exception = _handleStatusCode(err);
        break;

      case DioExceptionType.cancel:
        exception = const AppException(message: 'Request cancelled');
        break;

      case DioExceptionType.unknown:
        exception = AppException(
          message: err.message ?? 'An unexpected error occurred',
        );
        break;

      default:
        exception = AppException(
          message: err.message ?? 'An unexpected error occurred',
        );
    }

    // Replace the error with our custom exception
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        response: err.response,
        type: err.type,
      ),
    );
  }

  AppException _handleStatusCode(DioException err) {
    final statusCode = err.response?.statusCode;
    final message = _extractErrorMessage(err.response?.data);

    switch (statusCode) {
      case 400:
        return BadRequestException(
          message: message.isEmpty ? 'Bad request' : message,
          statusCode: statusCode,
        );
      case 401:
        return UnauthorizedException(
          message: message.isEmpty ? 'Unauthorized access' : message,
          statusCode: statusCode,
        );
      case 403:
        return AuthException(
          message: message.isEmpty ? 'Access forbidden' : message,
          statusCode: statusCode,
        );
      case 404:
        return NotFoundException(
          message: message.isEmpty ? 'Resource not found' : message,
          statusCode: statusCode,
        );
      case 422:
        return ValidationException(
          message: message.isEmpty ? 'Validation error' : message,
        );
      case 500:
      case 502:
      case 503:
        return InternalServerException(
          message: message.isEmpty
              ? 'Internal server error. Please try again later.'
              : message,
          statusCode: statusCode,
        );
      default:
        return ServerException(
          message: message.isEmpty ? 'Server error occurred' : message,
          statusCode: statusCode,
        );
    }
  }

  String _extractErrorMessage(dynamic responseData) {
    if (responseData == null) return '';

    try {
      if (responseData is Map) {
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
}
