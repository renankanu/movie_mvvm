import 'package:movie_mvvm/core/errors/server_exception.dart';
import 'package:movie_mvvm/core/http_client/http_client.dart';
import 'package:movie_mvvm/model/movie.dart';

abstract class RemoveMovieDataSource {
  Future<List<Movie>> getTrendTodayMovies();
}

class RemoveMovieDataSourceImpl implements RemoveMovieDataSource {
  final DioClient client;

  RemoveMovieDataSourceImpl(this.client);

  @override
  Future<List<Movie>> getTrendTodayMovies() async {
    final response = await client.get('/movie');

    if (response.statusCode == 200) {
      final List<Movie> movies = [];
      for (final item in response.data['results']) {
        movies.add(Movie.fromJson(item));
      }
      return movies;
    } else {
      throw ServerException();
    }
  }
}
