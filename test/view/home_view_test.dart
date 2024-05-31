import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_mvvm/view_model/movie_cubit/movie_cubit.dart';

import '../_utils/_mock/mocks.mocks.dart';

void main() {
  testWidgets('', (WidgetTester tester) async {
    final movieCubit = MovieCubit(MockMovieRepository());
    await tester.pumpWidget(
      BlocProvider(
        create: (context) => movieCubit,
        child: MaterialApp(
          home: Scaffold(
            body: BlocBuilder<MovieCubit, MovieState>(
              builder: (context, state) {
                if (state is MovieInitialState) {
                  return const Text('Initial');
                } else if (state is MovieLoadingState) {
                  return const Text('Loading');
                } else if (state is MovieLoadedState) {
                  return const Text('Loaded');
                } else if (state is MovieErrorState) {
                  return const Text('Error');
                } else {
                  return const Text('Unknown');
                }
              },
            ),
          ),
        ),
      ),
    );

    expect(find.text('Initial'), findsOneWidget);
    movieCubit.emit(MovieLoadingState());
    await tester.pump();
    expect(find.text('Loading'), findsOneWidget);
    movieCubit.emit(const MovieLoadedState([]));
    await tester.pump();
    expect(find.text('Loaded'), findsOneWidget);
  });
}
