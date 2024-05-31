import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_mvvm/core/errors/errors.dart';
import 'package:movie_mvvm/model/movie.dart';
import 'package:movie_mvvm/repository/movie_repository.dart';
import 'package:movie_mvvm/view_model/movie_cubit/movie_cubit.dart';

import '../../_utils/_mock/mocks.mocks.dart';

void main() {
  late MovieRepository mockMovieRepository;
  late List<Movie> tListMovie;
  setUpAll(() {
    mockMovieRepository = MockMovieRepository();
    tListMovie = [
      Movie(
        title: 'Title',
        overview: 'Overview',
        originalLanguage: 'en',
        popularity: 1.0,
        releaseDate: '2022-01-01',
        voteAverage: 1.0,
        voteCount: 1,
        posterPath: 'posterPath',
      ),
    ];
  });

  blocTest<MovieCubit, MovieState>(
    'emits [MovieInitial, MovieLoaded] when getMovies is called',
    build: () {
      provideDummy<Either<Failure, List<Movie>>>(
        Right(tListMovie),
      );

      when(mockMovieRepository.getTrendTodayMovies()).thenAnswer((_) async {
        return Right(tListMovie);
      });

      return MovieCubit(mockMovieRepository);
    },
    act: (cubit) => cubit.getMovies(),
    expect: () => [
      MovieLoadingState(),
      MovieLoadedState(tListMovie),
    ],
  );

  blocTest<MovieCubit, MovieState>(
    'emits [MovieInitial, MovieError] when getMovies is called',
    build: () {
      provideDummy<Either<Failure, List<Movie>>>(
        const Left(ServerFailure('Error')),
      );

      when(mockMovieRepository.getTrendTodayMovies()).thenAnswer((_) async {
        return const Left(ServerFailure('Error'));
      });

      return MovieCubit(mockMovieRepository);
    },
    act: (cubit) => cubit.getMovies(),
    expect: () => [
      MovieLoadingState(),
      const MovieErrorState('Error'),
    ],
  );
}
