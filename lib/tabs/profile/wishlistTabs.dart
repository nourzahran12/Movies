import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import '../../movies_details_screen.dart';
import '../../providers/watch_history_provider.dart';
import '../../providers/movies_details_provider.dart';

class WatchHistoryTabs extends StatefulWidget {
  @override
  State<WatchHistoryTabs> createState() => _WatchHistoryTabsState();
}

class _WatchHistoryTabsState extends State<WatchHistoryTabs> {
  int currentIndex = 0;
  PageController pageController = PageController();

  void onTabClick(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final favouriteMovie = Provider.of<MovieDetailsPorvider>(context);
    final history = Provider.of<WatchHistory>(context);
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          color: AppTheme.darkGray,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabClick(0),
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/list.svg'),
                      SizedBox(height: 5),
                      Text("Watch List", style: textTheme.titleMedium),
                      SizedBox(height: 8),

                      Container(
                        height: 3,
                        color: currentIndex == 0
                            ? AppTheme.primary
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabClick(1),
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/history.svg'),
                      SizedBox(height: 5),
                      Text("History", style: textTheme.titleMedium),
                      SizedBox(height: 8),
                      Container(
                        height: 3,
                        color: currentIndex == 1
                            ? AppTheme.primary
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 10),

        Expanded(
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              favouriteMovie.favouriteMoviesList.isEmpty
                  ? Center(
                      child: Image.asset('assets/images/Empty.png', width: 100),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: favouriteMovie.favouriteMoviesList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, i) {
                        final movie = favouriteMovie.favouriteMoviesList[i];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MoviesDetailsScreen(movieId: movie["id"]),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppTheme.darkGray,
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    movie["coverImage"],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),

                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 14,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          movie["movieRate"].toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

              history.watchHistoryMoviesList.isEmpty
                  ? Center(
                      child: Image.asset('assets/images/Empty.png', width: 100),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: history.watchHistoryMoviesList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, i) {
                        final movie = history.watchHistoryMoviesList[i];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MoviesDetailsScreen(movieId: movie["id"]),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppTheme.darkGray,
                            ),
                            child: Stack(
                              children: [
                                /// 🔥 Cover
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    movie["coverImage"],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),

                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 14,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          movie["movieRate"].toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
