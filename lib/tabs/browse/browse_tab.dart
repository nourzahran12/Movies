import 'package:flutter/material.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/movies_details_screen.dart';
import 'package:movies/widgets/genre_filter_bar.dart';
import 'package:movies/widgets/loading_indicator.dart';
import 'package:movies/widgets/similar_item.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  final List<String> genres = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Drama',
    'Family',
    'Fantasy',
  ];

  String selectedGenre = 'Action';
  List<Movie> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMovies(selectedGenre);
  }

  Future<void> _fetchMovies(String genre) async {
    setState(() {
      isLoading = true;
      selectedGenre = genre;
    });

    try {
      final results = await ApiService.fetchMoviesByGenre(genre);
      setState(() {
        movies = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint("Browse Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            GenreFilterBar(
              genres: genres,
              selectedGenre: selectedGenre,
              onGenreSelected: (genre) {
                _fetchMovies(genre);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? const Center(child: LoadingIndicator())
                  : movies.isEmpty
                  ? Center(
                      child: Text(
                        "No movies found",
                        style: textTheme.titleMedium,
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.65,
                          ),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MoviesDetailsScreen(movieId: movie.id),
                              ),
                            );
                          },
                          child: SimilarItem(
                            url: movie.largeCoverImage,
                            rate: movie.rating.toString(),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
