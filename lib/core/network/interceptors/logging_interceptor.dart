import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Logging interceptor for debugging network requests
class LoggingInterceptor extends Interceptor {
  final Logger _logger;

  LoggingInterceptor(this._logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d(
      '━━━━━━━━━━━━━━━━━━ REQUEST ━━━━━━━━━━━━━━━━━━\n'
      'METHOD: ${options.method}\n'
      'URL: ${options.uri}\n'
      'HEADERS: ${options.headers}\n'
      'DATA: ${options.data}\n'
      'QUERY PARAMETERS: ${options.queryParameters}\n'
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i(
      '━━━━━━━━━━━━━━━━━━ RESPONSE ━━━━━━━━━━━━━━━━━\n'
      'STATUS CODE: ${response.statusCode}\n'
      'URL: ${response.requestOptions.uri}\n'
      'HEADERS: ${response.headers}\n'
      'DATA: ${response.data}\n'
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      '━━━━━━━━━━━━━━━━━━ ERROR ━━━━━━━━━━━━━━━━━━━━\n'
      'TYPE: ${err.type}\n'
      'MESSAGE: ${err.message}\n'
      'URL: ${err.requestOptions.uri}\n'
      'STATUS CODE: ${err.response?.statusCode}\n'
      'DATA: ${err.response?.data}\n'
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
    );
    handler.next(err);
  }
}
