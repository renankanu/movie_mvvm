import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LogInterceptor extends Interceptor {
  var logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logLine(Level.info, 'REQUEST => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logLine(Level.info,
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logLine(Level.error, err.error.toString());
    return super.onError(err, handler);
  }

  void _logLine(Level level, String message) {
    logger.log(level, message);
  }
}
