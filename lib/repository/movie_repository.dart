import '../model/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getTrendTodayMovies();
}
