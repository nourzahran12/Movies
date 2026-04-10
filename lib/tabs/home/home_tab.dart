import 'package:flutter/material.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/widgets/loading_indicator.dart';
import 'package:movies/widgets/movie_section.dart';
import 'home_header.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Future<List<Movie>> moviesFuture;
  late Future<List<Movie>> actionMovies;
  late Future<List<Movie>> animationMovies;
  late Future<List<Movie>> dramaMovies;
  late Future<List<Movie>> sciFiMovies;
  late Future<List<Movie>> comedyMovies;

  @override
  void initState() {
    super.initState();
    moviesFuture = ApiService.fetchMovies();
    actionMovies = ApiService.fetchMoviesByGenre('Action');
    animationMovies = ApiService.fetchMoviesByGenre('Animation');
    dramaMovies = ApiService.fetchMoviesByGenre('Drama');
    sciFiMovies = ApiService.fetchMoviesByGenre('Sci-Fi');
    comedyMovies = ApiService.fetchMoviesByGenre('Comedy');
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: FutureBuilder<List<Movie>>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text("Error", style: textTheme.titleMedium));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                HomeHeader(movies: snapshot.data!),
                MovieSection(title: 'Action', future: actionMovies),
                MovieSection(title: 'Animation', future: animationMovies),
                MovieSection(title: 'Drama', future: dramaMovies),
                MovieSection(title: 'Sci-Fi', future: sciFiMovies),
                MovieSection(title: 'Comedy', future: comedyMovies),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
