import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_theme.dart';

import '../../../data/api/api_service.dart';
import '../../../data/models/movie_model.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../../movies/view/movies_details_screen.dart';
import '../../movies/view/widgets/similar_item.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
  late Future<List<Movie>> moviesFuture;

  @override
  void initState() {
    super.initState();
    moviesFuture = ApiService.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppTheme.black,
      body: FutureBuilder<List<Movie>>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          } else if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Error loading movies",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final List<Movie> movies = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        key: ValueKey<String>('bg_${movies[currentIndex].id}'),
                        height: 620,
                        width: double.infinity,
                        child: Image.network(
                          movies[currentIndex].largeCoverImage,
                          fit: BoxFit.cover,
                          // معالج الخطأ للخلفية المتغيرة في الهوم
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppTheme.black,
                              child: const Center(
                                child: Icon(
                                  Icons.movie_filter,
                                  color: AppTheme.gray,
                                  size: 80,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Gradient Overlay
                    Container(
                      height: 620,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppTheme.black.withOpacity(0.3),
                            AppTheme.black.withOpacity(0.8),
                            AppTheme.black,
                          ],
                        ),
                      ),
                    ),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Image.asset('assets/images/Available Now.png'),
                      ),
                    ),

                    // 1. Carousel Slider
                    Padding(
                      padding: const EdgeInsets.only(top: 160),
                      child: CarouselSlider.builder(
                        itemCount: movies.length,
                        itemBuilder: (_, index, __) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MoviesDetailsScreen(
                                  movieId: movies[index].id,
                                ), // استخدام .id
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 200,
                            child: SimilarItem(
                              url: movies[index].largeCoverImage,
                              // استخدام .largeCoverImage
                              rate: movies[index].rating
                                  .toString(), // استخدام .rating
                            ),
                          ),
                        ),
                        options: CarouselOptions(
                          height: 320,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.50,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      top: 480,
                      left: 35,
                      child: Image.asset('assets/images/Watch Now.png'),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Action',
                        style: textTheme.titleMedium!.copyWith(
                          color: AppTheme.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right_alt,
                        size: 20,
                        color: AppTheme.primary,
                      ),
                    ],
                  ),
                ),

                // 2. Horizontal ListView
                SizedBox(
                  height: 240,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoviesDetailsScreen(
                              movieId: movies[index].id,
                            ), // استخدام .id
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 150,
                        child: SimilarItem(
                          url: movies[index]
                              .largeCoverImage, // استخدام .largeCoverImage
                          rate: movies[index].rating
                              .toString(), // استخدام .rating
                        ),
                      ),
                    ),
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
