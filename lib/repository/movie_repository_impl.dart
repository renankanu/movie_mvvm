import 'package:movie_mvvm/model/movie.dart';
import 'package:movie_mvvm/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  @override
  Future<List<Movie>> getTrendTodayMovies() async {
    throw UnimplementedError();
  }
}
