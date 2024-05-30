import 'package:movie_mvvm/core/http_client/api_response.dart';

typedef MapParams = Map<String, dynamic>?;

abstract class Client {
  Future<ApiResponse> get(
    String url, {
    MapParams? headers,
    MapParams? queryParameters,
  });
}
