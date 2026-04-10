import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/widgets/loading_indicator.dart';
import 'package:movies/widgets/movie_stat_chip.dart';
import 'package:movies/widgets/cast_item.dart';
import 'package:movies/widgets/defaulte_botton.dart';
import 'package:movies/widgets/genre_item.dart';
import 'package:movies/widgets/screenshot_Item.dart';
import 'package:movies/widgets/similar_item.dart';

class MoviesDetailsScreen extends StatefulWidget {
  static const String routeName = '/MoviesDetailsScreen';
  final int movieId;

  const MoviesDetailsScreen({super.key, required this.movieId});

  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {
  late Future<Movie> movieDetailsFuture;
  late Future<List<Movie>> similarMoviesFuture;

  @override
  void initState() {
    super.initState();
    movieDetailsFuture = ApiService.getMovieDetails(widget.movieId);
    similarMoviesFuture = ApiService.getSimilarMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppTheme.black,
      body: FutureBuilder<Movie>(
        future: movieDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text(
                "Error loading details",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final movie = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      movie.largeCoverImage,
                      height: screenHeight * 0.69,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      // إضافة معالج الأخطاء هنا
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: screenHeight * 0.69,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.grey[900]!, // لون داكن من الأعلى
                                AppTheme.black, // يندمج مع الخلفية السوداء
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: Colors.white24,
                              size: 60,
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      height: screenHeight * 0.69,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, AppTheme.black],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.black26,
                          child: Image.asset('assets/images/play.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 16,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          'assets/icons/back.svg',
                          width: 17,
                          height: 29,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 16,
                      child: GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/icons/save.svg',
                          width: 20,
                          height: 30,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      left: 16,
                      right: 16,
                      child: Column(
                        children: [
                          Text(
                            movie.title,
                            style: textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            movie.year,
                            style: textTheme.titleMedium!.copyWith(
                              color: AppTheme.lightgray,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaulteBotton(
                        text: 'Watch',
                        onPressed: () {},
                        colorBotton: AppTheme.red,
                        textColor: AppTheme.white,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: MovieStatChip(
                              icon: SvgPicture.asset(
                                'assets/icons/heart.svg',
                                width: 18,
                              ),
                              text: movie.likeCount.toString(),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: MovieStatChip(
                              icon: SvgPicture.asset(
                                'assets/icons/time.svg',
                                width: 18,
                              ),
                              text: '${movie.runtime}',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: MovieStatChip(
                              icon: SvgPicture.asset(
                                'assets/icons/star.svg',
                                width: 18,
                              ),
                              text: movie.rating.toString(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      if (movie.screenshots != null &&
                          movie.screenshots!.isNotEmpty) ...[
                        Text("Screen Shots", style: textTheme.titleLarge),
                        const SizedBox(height: 10),
                        ...movie.screenshots!
                            .map((url) => ScreenshotItem(url: url))
                            .toList(),
                      ],

                      const SizedBox(height: 16),
                      Text("Similar", style: textTheme.titleLarge),
                      const SizedBox(height: 16),

                      FutureBuilder<List<Movie>>(
                        future: similarMoviesFuture,
                        builder: (context, simSnapshot) {
                          if (!simSnapshot.hasData) return const SizedBox();
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: simSnapshot.data!.length > 4
                                ? 4
                                : simSnapshot.data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.6,
                                ),
                            itemBuilder: (context, index) {
                              final simMovie = simSnapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MoviesDetailsScreen(
                                        movieId: simMovie.id,
                                      ),
                                    ),
                                  );
                                },
                                child: SimilarItem(
                                  url: simMovie.largeCoverImage,
                                  rate: simMovie.rating.toString(),
                                ),
                              );
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 16),
                      Text("Summary", style: textTheme.titleLarge),
                      const SizedBox(height: 10),
                      Text(
                        movie.summary,
                        style: textTheme.titleSmall!.copyWith(
                          color: AppTheme.white,
                        ),
                      ),

                      const SizedBox(height: 20),
                      Text("Cast", style: textTheme.titleLarge),
                      const SizedBox(height: 15),

                      if (movie.cast != null)
                        ...movie.cast!
                            .map(
                              (c) => CastItem(
                                img:
                                    c.urlSmallImage ??
                                    "https://via.placeholder.com/150",
                                name: c.name,
                                character: c.characterName,
                              ),
                            )
                            .toList(),

                      const SizedBox(height: 16),
                      Text("Genres", style: textTheme.titleLarge),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 16,
                        runSpacing: 11,
                        children: movie.genres
                            .map((g) => GenreItem(text: g))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
