import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_mvvm/core/errors/errors.dart';
import 'package:movie_mvvm/core/http_client/http_client.dart';
import 'package:movie_mvvm/data/remote/movies.dart';

import '../../_utils/_mock/mocks.mocks.dart';
import '../../_utils/json_reader.dart';

void main() {
  late RemoteMovieDataSourceImpl dataSource;
  late MockDioClient mockDioClient;

  setUp(() async {
    mockDioClient = MockDioClient();
    dataSource = RemoteMovieDataSourceImpl(mockDioClient);
  });

  group('Remote Movie Data Source', () {
    test('it should return list of trend day movies', () {
      // arrange
      final jsonMap = jsonReader('movie_day.json');
      when(mockDioClient.get(any)).thenAnswer(
        (_) async => ApiResponse(
          jsonMap,
          statusCode: 200,
        ),
      );
      // act
      final result = dataSource.getTrendTodayMovies();
      // assert
      expect(result, completes);
    });

    test('it should trow ServerException if status diff 200', () {
      //arrange
      when(mockDioClient.get(any)).thenAnswer(
        (_) async => ApiResponse(
          {},
          statusCode: 404,
        ),
      );
      // act
      final result = dataSource.getTrendTodayMovies();
      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
