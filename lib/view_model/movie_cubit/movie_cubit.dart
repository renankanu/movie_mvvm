import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/movie.dart';
import '../../repository/movie_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit(this.movieRepository) : super(MovieInitialState());

  final MovieRepository movieRepository;

  Future<void> getMovies() async {
    emit(MovieLoadingState());
    final result = await movieRepository.getTrendTodayMovies();
    result.fold(
      (error) => emit(MovieErrorState('Error: $error')),
      (success) => emit(MovieLoadedState(success)),
    );
  }
}
