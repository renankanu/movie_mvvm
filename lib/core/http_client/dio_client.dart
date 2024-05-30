import 'package:dio/dio.dart';
import 'package:movie_mvvm/core/constants/app_url.dart';
import 'package:movie_mvvm/core/http_client/api_response.dart';
import 'package:movie_mvvm/core/http_client/client.dart';

class DioClient implements Client {
  late Dio _dio;

  DioClient() {
    _dio = Dio();
    _dio.options.baseUrl = AppUrl.baseUrl;
    _dio.options.connectTimeout = const Duration(minutes: 1);
    _dio.options.receiveTimeout = const Duration(minutes: 1);
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  @override
  Future<ApiResponse> get(
    String url, {
    MapParams? headers,
    MapParams? queryParameters,
  }) async {
    final response = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );

    return ApiResponse(
      response.data,
      message: response.statusMessage,
      statusCode: response.statusCode,
    );
  }
}
