import 'package:mockito/annotations.dart';
import 'package:movie_mvvm/core/http_client/http_client.dart';
import 'package:movie_mvvm/data/remote/movies.dart';
import 'package:movie_mvvm/repository/movie_repository.dart';

@GenerateMocks([
  DioClient,
  MovieRepository,
  RemoteMovieDataSource,
])
void main() {}
