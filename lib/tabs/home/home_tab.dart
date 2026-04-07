import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/widgets/similar_item.dart';
class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}
class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
  List<String> images = [
    'https://image.tmdb.org/t/p/w500/8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg',
    'https://image.tmdb.org/t/p/w500/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg',
    'https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg',
    'https://image.tmdb.org/t/p/w500/6DrHO1jr3qVrViUO6s6kFiAGM7.jpg',
    'https://image.tmdb.org/t/p/w500/5P8SmMzSNYikXpxil6BYzJ16611.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    key: ValueKey(images[currentIndex]),
                    height: 620,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(images[currentIndex]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.only(top: 160),
                  child: CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: (_, index, __) => SizedBox(
                      width: 200,
                      child: SimilarItem(url: images[index], rate: '7.7'),
                    ),
                    options: CarouselOptions(
                      height: 320,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 4),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    url: images[index % images.length],
                    rate: '7.7',
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
