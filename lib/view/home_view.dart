import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/movie_cubit/movie_cubit.dart';
import 'components/item_movie.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<MovieCubit>().getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            return switch (state) {
              MovieLoadingState() => const CircularProgressIndicator(),
              MovieLoadedState() => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return ItemMovie(movie: movie);
                  },
                ),
              MovieErrorState() => Text(state.message),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}
