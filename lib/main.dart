import 'package:flutter/material.dart';
import 'package:movie_mvvm/view/home_view.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie MVVM Architecture',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
