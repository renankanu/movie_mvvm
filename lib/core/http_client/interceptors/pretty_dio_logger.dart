import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AnsiColor {
  static const String reset = '\x1B[0m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';
}

enum LogLevel { request, response, error }

class PrettyDioLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final uri = options.uri;
    final method = options.method;

    final icon = _makeLogIcon(LogLevel.request);
    _printLine(LogLevel.request, message: '$icon Request ║ $method ');
    _printLine(LogLevel.request, message: uri.toString());
    _printLine(LogLevel.request, message: '${options.headers}');
    if (options.data is FormData) {
      _printLine(LogLevel.request, message: 'FormData');
    } else {
      _printLine(
        LogLevel.request,
        message: jsonEncode(options.data ?? '{data: NO BODY DATA}'),
      );
    }
    _newLine(LogLevel.request);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    final uri = response.requestOptions.uri;
    final method = response.requestOptions.method;

    final icon = _makeLogIcon(LogLevel.response);
    _printLine(LogLevel.response,
        message: '$icon Response ║ $method ║ $statusCode');
    _printLine(LogLevel.response, message: uri.toString());
    _printLine(LogLevel.response, message: '${response.data}');
    _newLine(LogLevel.response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final uri = err.requestOptions.uri;
    final method = err.requestOptions.method;

    final icon = _makeLogIcon(LogLevel.error);
    _printLine(LogLevel.error, message: '$icon Error ║ $method');
    _printLine(LogLevel.error, message: uri.toString());
    _printLine(LogLevel.error, message: '${err.message}');
    _newLine(LogLevel.error);

    super.onError(err, handler);
  }

  void _printLine(LogLevel level, {required String message}) {
    final color = switch (level) {
      LogLevel.request => AnsiColor.cyan,
      LogLevel.response => AnsiColor.green,
      LogLevel.error => AnsiColor.red,
    };
    debugPrint('$color $message ${AnsiColor.reset}');
  }

  String _makeLogIcon(LogLevel level) {
    return switch (level) {
      LogLevel.request => '🚀',
      LogLevel.response => '🎯',
      LogLevel.error => '🔥',
    };
  }

  void _newLine(LogLevel level) {
    _printLine(level, message: '╚${'═' * 120}╝');
    debugPrint('');
  }
}
