part of 'movie_cubit.dart';

class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitialState extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  final List<Movie> movies;

  const MovieLoadedState(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieErrorState extends MovieState {
  final String message;

  const MovieErrorState(this.message);

  @override
  List<Object> get props => [message];
}
