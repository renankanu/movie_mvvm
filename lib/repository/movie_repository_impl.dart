import 'package:fpdart/fpdart.dart';
import 'package:movie_mvvm/repository/movie_repository.dart';

import '../core/errors/errors.dart';
import '../data/remote/movies.dart';
import '../model/movie.dart';

class MovieRepositoryImpl implements MovieRepository {
  final RemoteMovieDataSource dataSource;

  MovieRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Movie>>> getTrendTodayMovies() async {
    try {
      final movies = await dataSource.getTrendTodayMovies();
      return Right(movies);
    } on ServerException {
      return const Left(
        ServerFailure('Não foi possível carregar os filmes do dia'),
      );
    }
  }
}
