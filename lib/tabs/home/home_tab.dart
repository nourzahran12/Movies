import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/widgets/similar_item.dart';
import 'package:movies/api/api_service.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
  List<dynamic> movies = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      movies = await ApiService.getMovies();
    } catch (e) {
      errorMessage = e.toString();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 🟢 Loading
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    /// 🔴 Error
    if (errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Error: $errorMessage",
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    /// 🔴 No Data
    if (movies.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No Movies Found")),
      );
    }

    /// 🟡 Fix index
    if (currentIndex >= movies.length) {
      currentIndex = 0;
    }

    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                /// 🔥 Background Image
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    key: ValueKey(currentIndex),
                    height: 620,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          movies[currentIndex]['medium_cover_image'] ??
                              "https://via.placeholder.com/300",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                /// Gradient
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

                /// Available Now
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Image.asset('assets/images/Available Now.png'),
                  ),
                ),

                /// 🔥 Carousel
                Padding(
                  padding: const EdgeInsets.only(top: 160),
                  child: CarouselSlider.builder(
                    itemCount: movies.length,
                    itemBuilder: (_, index, __) => SizedBox(
                      width: 200,
                      child: SimilarItem(
                        url: movies[index]['medium_cover_image'] ?? "",
                        rate: movies[index]['rating'].toString(),
                      ),
                    ),
                    options: CarouselOptions(
                      height: 320,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 4),
                      enlargeCenterPage: true,
                      viewportFraction: 0.50,
                      enlargeFactor: 0.3,
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

            /// Section Title
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Movies',
                    style: textTheme.titleMedium!
                        .copyWith(color: AppTheme.white),
                  ),
                  Icon(
                    Icons.arrow_right_alt,
                    size: 20,
                    color: AppTheme.primary,
                  ),
                ],
              ),
            ),

            /// 🔥 Bottom List
            SizedBox(
              height: 240,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 10,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => SizedBox(
                  width: 150,
                  child: SimilarItem(
                    url: movies[index]['medium_cover_image'] ?? "",
                    rate: movies[index]['rating'].toString(),
                  ),
                ),
                separatorBuilder: (context, index) =>
                const SizedBox(width: 10),
                itemCount: movies.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}