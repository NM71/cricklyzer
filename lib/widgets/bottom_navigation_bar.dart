import 'package:cricklyzer/screens/cric_score.dart';
import 'package:flutter/material.dart';
import 'package:cricklyzer/Screens/learning_hub.dart';
import 'package:cricklyzer/Screens/home_screen.dart';
import 'package:cricklyzer/Screens/statistics_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  const CustomBottomNavigationBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: const Color(0xffffffff),
      elevation: 0,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined, color: Color(0xffe01312), size: 26,),
          selectedIcon: Icon(Icons.home, color: Color(0xffe01312), size: 26,),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.scoreboard_outlined, color: Color(0xffe01312), size: 26,),
          selectedIcon: Icon(Icons.scoreboard, color: Color(0xffe01312), size: 26,),
          label: 'CricScore',
        ),
        NavigationDestination(
          icon: Icon(Icons.bar_chart_outlined,color: Color(0xffe01312), size: 26,),
          selectedIcon: Icon(Icons.bar_chart,color: Color(0xffe01312), size: 26,),
          label: 'Stats',
        ),
        NavigationDestination(
          icon: Icon(Icons.sports_cricket_outlined,color: Color(0xffe01312), size: 26,),
          selectedIcon: Icon(Icons.sports_cricket,color: Color(0xffe01312), size: 26,),
          label: 'Learn Hub'
        ),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            break;
          case 1:
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CricScore()),
            );
            break;
          case 2:
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StatisticsScreen()),
            );
            break;
          case 3:
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LearningHub()),
            );
            break;
        }
      },
    );
  }
}