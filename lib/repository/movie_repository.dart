import 'package:fpdart/fpdart.dart';

import '../core/errors/errors.dart';
import '../model/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getTrendTodayMovies();
}
