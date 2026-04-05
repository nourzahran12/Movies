import 'package:flutter/material.dart';
import 'package:movies/Home_card.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/Home background.png'),
                Center(child: Image.asset('assets/images/Available Now.png')),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 120,
                    horizontal: 100,
                  ),
                  child: HomeCard(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
