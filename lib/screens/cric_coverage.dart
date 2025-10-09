import 'package:cricklyzer/screens/cric_score.dart';
import 'package:cricklyzer/screens/cricket_news_screen.dart';
import 'package:cricklyzer/widgets/appbar.dart';
import 'package:cricklyzer/widgets/bottom_navigation_bar.dart';
import 'package:cricklyzer/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';

class CricketCoverage extends StatelessWidget {
  const CricketCoverage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: const CustomAppBar(),
      bottomNavigationBar: const CustomBottomNavigationBar(
        selectedIndex: 1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Live Scores',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CricScore(),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Cricket News',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CricketNewsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
