import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/widgets/movie_stat_chip.dart';
import 'package:movies/widgets/cast_item.dart';
import 'package:movies/widgets/defaulte_botton.dart';
import 'package:movies/widgets/genre_item.dart';
import 'package:movies/widgets/screenshot_Item.dart';
import 'package:movies/widgets/similar_item.dart';

class MoviesDetailsScreen extends StatelessWidget {
  static const String routeName = '/MoviesDetailsScreen';

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/DoctorStrange.png",
                  height: screenHeight * 0.69,
                  width: double.infinity,
                  fit: BoxFit.cover,
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
                      child: Image.asset('assets/images/play.png'),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                        "Doctor Strange in the Multiverse of Madness",
                        style: textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "2022",
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
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: MovieStatChip(
                          icon: SvgPicture.asset(
                            'assets/icons/heart.svg',
                            width: 18,
                          ),
                          text: '15',
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: MovieStatChip(
                          icon: SvgPicture.asset(
                            'assets/icons/time.svg',
                            width: 18,
                          ),
                          text: '90',
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: MovieStatChip(
                          icon: SvgPicture.asset(
                            'assets/icons/star.svg',
                            width: 18,
                          ),
                          text: '7.6',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Screen Shots", style: textTheme.titleLarge),
                  SizedBox(height: 10),
                  ScreenshotItem(
                    url:
                        "https://image.tmdb.org/t/p/w500/8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg",
                  ),
                  ScreenshotItem(
                    url:
                        "https://image.tmdb.org/t/p/w500/8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg",
                  ),
                  ScreenshotItem(
                    url:
                        "https://image.tmdb.org/t/p/w500/8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg",
                  ),

                  SizedBox(height: 16),
                  Text("Similar", style: textTheme.titleLarge),
                  SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.6,
                    children: [
                      SimilarItem(
                        url:
                            "https://image.tmdb.org/t/p/w500/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg",
                        rate: '7.7',
                      ),
                      SimilarItem(
                        url:
                            "https://image.tmdb.org/t/p/w500/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg",
                        rate: '7.7',
                      ),
                      SimilarItem(
                        url:
                            "https://image.tmdb.org/t/p/w500/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg",
                        rate: '7.7',
                      ),
                      SimilarItem(
                        url:
                            "https://image.tmdb.org/t/p/w500/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg",
                        rate: '7.7',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  Text("Summary", style: textTheme.titleLarge),
                  SizedBox(height: 10),
                  Text(
                    "Following the events of Spider-Man No Way Home...Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346",
                    style: textTheme.titleSmall!.copyWith(
                      color: AppTheme.white,
                    ),
                  ),
                  SizedBox(height: 20),

                  Text("Cast", style: textTheme.titleLarge),
                  SizedBox(height: 15),
                  CastItem(
                    img:
                        "https://image.tmdb.org/t/p/w500/8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg",
                    name: "Hayley Atwell",
                    character: "Captain Carter",
                  ),
                  CastItem(
                    img:
                        "https://image.tmdb.org/t/p/w500/8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg",
                    name: "Hayley Atwell",
                    character: "Captain Carter",
                  ),
                  CastItem(
                    img:
                        "https://image.tmdb.org/t/p/w500/8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg",
                    name: "Hayley Atwell",
                    character: "Captain Carter",
                  ),
                  CastItem(
                    img:
                        "https://image.tmdb.org/t/p/w500/8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg",
                    name: "Hayley Atwell",
                    character: "Captain Carter",
                  ),
                  SizedBox(height: 10),
                  CastItem(
                    img:
                        "https://image.tmdb.org/t/p/w500/8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg",
                    name: "Hayley Atwell",
                    character: "Captain Carter",
                  ),
                  CastItem(
                    img:
                        "https://image.tmdb.org/t/p/w500/8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg",
                    name: "Hayley Atwell",
                    character: "Captain Carter",
                  ),
                  CastItem(
                    img:
                        "https://image.tmdb.org/t/p/w500/8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg",
                    name: "Hayley Atwell",
                    character: "Captain Carter",
                  ),
                  SizedBox(height: 16),
                  Text("Genres", style: textTheme.titleLarge),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 16,
                    runSpacing: 11,
                    children: [
                      GenreItem(text: "Action"),
                      GenreItem(text: "Sci-Fi"),
                      GenreItem(text: "Adventure"),
                      GenreItem(text: "Fantasy"),
                      GenreItem(text: "Horror"),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
