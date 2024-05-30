import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_mvvm/core/http_client/interceptors/auth_interceptor.dart';
import 'package:movie_mvvm/core/http_client/interceptors/pretty_dio_logger.dart';

class MockDio extends Mock implements Dio {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockResponseInterceptorHandler extends Mock
    implements ResponseInterceptorHandler {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

// Test created for the interceptors
// PrettyDioLogger and AuthInterceptor
// This test is not required, but it is good to have it
void main() {
  group('Pretty Dio Interceptor', () {
    final mockRequestHandler = MockRequestInterceptorHandler();
    final mockResponseHandler = MockResponseInterceptorHandler();
    final mockErrorHandler = MockErrorInterceptorHandler();
    final prettyDioLogger = PrettyDioLogger();

    test('logs request', () {
      final options = RequestOptions(
        path: '/test',
        method: 'GET',
      );

      prettyDioLogger.onRequest(options, mockRequestHandler);

      verify(mockRequestHandler.next(options)).called(1);
    });

    test('logs request with FormData', () {
      final options = RequestOptions(
        path: '/test',
        method: 'POST',
        data: FormData.fromMap({'key': 'value'}),
      );

      prettyDioLogger.onRequest(options, mockRequestHandler);

      verify(mockRequestHandler.next(options)).called(1);
    });

    test('logs response', () {
      final response = Response(
        requestOptions: RequestOptions(
          path: '/test',
          method: 'GET',
        ),
        statusCode: 200,
        data: {'data': 'test'},
      );

      prettyDioLogger.onResponse(response, mockResponseHandler);

      verify(mockResponseHandler.next(response)).called(1);
    });

    test('logs error', () {
      final error = DioException(
        requestOptions: RequestOptions(
          path: '/test',
          method: 'GET',
        ),
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(
            path: '/test',
            method: 'GET',
          ),
          data: {'data': 'test'},
        ),
      );

      prettyDioLogger.onError(error, mockErrorHandler);

      verify(mockErrorHandler.next(error)).called(1);
    });
  });

  group('Authentication Interceptor', () {
    final authInterceptor = AuthInterceptor();

    test('adds Authorization header', () {
      dotenv.testLoad(fileInput: 'API_KEY=foo');
      final options = RequestOptions(
        path: '/test',
        method: 'GET',
      );

      authInterceptor.onRequest(options, RequestInterceptorHandler());

      expect(options.headers['Authorization'], isNotNull);
    });
  });
}
