import 'package:get_it/get_it.dart';
import 'package:movie_mvvm/core/http_client/http_client.dart';
import 'package:movie_mvvm/data/remote/movies.dart';
import 'package:movie_mvvm/repository/movie_repository.dart';
import 'package:movie_mvvm/view_model/movie_cubit/movie_cubit.dart';

import 'repository/movie_repository_impl.dart';

final injector = GetIt.instance;

void init() {
  injector
    ..registerSingleton<DioClient>(DioClient())

    //data
    ..registerLazySingleton<RemoteMovieDataSource>(
      () => RemoteMovieDataSourceImpl(injector()),
    )

    //repositories
    ..registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(injector()),
    )
    //cubit
    ..registerLazySingleton<MovieCubit>(() => MovieCubit(injector()));
}
