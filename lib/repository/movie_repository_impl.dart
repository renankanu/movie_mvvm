import 'package:fpdart/fpdart.dart';
import 'package:movie_mvvm/core/errors/errors.dart';
import 'package:movie_mvvm/model/movie.dart';
import 'package:movie_mvvm/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  @override
  Future<Either<Failure, List<Movie>>> getTrendTodayMovies() async {
    throw UnimplementedError();
  }
}
