import 'package:cricklyzer/screens/cric_coverage.dart';
import 'package:cricklyzer/Screens/learning_hub.dart';
import 'package:cricklyzer/Screens/home_screen.dart';
import 'package:cricklyzer/Screens/statistics_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  const CustomBottomNavigationBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xffe01312),
      unselectedItemColor: Colors.grey,
      currentIndex: selectedIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_convenience_store_outlined),
          activeIcon: Icon(Icons.scoreboard),
          label: 'Coverage',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_chart_outlined),
          activeIcon: Icon(Icons.insert_chart),
          label: 'Stats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_cricket_outlined),
          activeIcon: Icon(Icons.sports_cricket),
          label: 'Learn Hub',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CricketCoverage()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const StatisticsScreen()),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LearningHub()),
            );
            break;
        }
      },
    );
  }
}
































// import 'package:cricklyzer/screens/cric_coverage.dart';
// import 'package:flutter/material.dart';
// import 'package:cricklyzer/Screens/learning_hub.dart';
// import 'package:cricklyzer/Screens/home_screen.dart';
// import 'package:cricklyzer/Screens/statistics_screen.dart';
//
// class CustomBottomNavigationBar extends StatelessWidget {
//   final int selectedIndex;
//   const CustomBottomNavigationBar({super.key, required this.selectedIndex});
//
//   @override
//   Widget build(BuildContext context) {
//     return NavigationBar(
//       backgroundColor: const Color(0xffffffff),
//       elevation: 0,
//       destinations: const [
//         NavigationDestination(
//           icon: Icon(Icons.home_outlined, color: Color(0xffe01312), size: 24,),
//           selectedIcon: Icon(Icons.home, color: Color(0xffe01312), size: 24,),
//           label: 'Home',
//         ),
//         NavigationDestination(
//           icon: Icon(Icons.local_convenience_store_outlined, color: Color(0xffe01312), size: 24,),
//           selectedIcon: Icon(Icons.scoreboard, color: Color(0xffe01312), size: 24,),
//           label: 'Coverage',
//         ),
//         NavigationDestination(
//           icon: Icon(Icons.insert_chart_outlined,color: Color(0xffe01312), size: 24,),
//           selectedIcon: Icon(Icons.insert_chart,color: Color(0xffe01312), size: 24,),
//           label: 'Stats',
//         ),
//         NavigationDestination(
//           icon: Icon(Icons.sports_cricket_outlined,color: Color(0xffe01312), size: 25,),
//           selectedIcon: Icon(Icons.sports_cricket,color: Color(0xffe01312), size: 25,),
//           label: 'Learn Hub'
//         ),
//       ],
//       selectedIndex: selectedIndex,
//       onDestinationSelected: (index) {
//         switch (index) {
//           case 0:
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HomeScreen()),
//             );
//             break;
//           case 1:
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const CricketCoverage()),
//             );
//             break;
//           case 2:
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const StatisticsScreen()),
//             );
//             break;
//           case 3:
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const LearningHub()),
//             );
//             break;
//         }
//       },
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:cricklyzer/screens/home_screen.dart';
// import 'package:cricklyzer/screens/cric_coverage.dart';
// import 'package:cricklyzer/screens/statistics_screen.dart';
// import 'package:cricklyzer/screens/learning_hub.dart';
//
// class CustomBottomNavigationBar extends StatelessWidget {
//   final int selectedIndex;
//
//   const CustomBottomNavigationBar({Key? key, required this.selectedIndex}) : super(key: key);
//
//   static List<(IconData, IconData, String, Widget)> _destinations = [
//     (Icons.home_outlined, Icons.home, 'Home', HomeScreen()),
//     (Icons.local_convenience_store_outlined, Icons.scoreboard, 'Coverage', CricketCoverage()),
//     (Icons.insert_chart_outlined, Icons.insert_chart, 'Stats', StatisticsScreen()),
//     (Icons.sports_cricket_outlined, Icons.sports_cricket, 'Learn Hub', LearningHub()),
//   ];
//
//   void _onItemTapped(BuildContext context, int index) {
//     if (index != selectedIndex) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => _destinations[index].$4),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return NavigationBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       selectedIndex: selectedIndex,
//       onDestinationSelected: (index) => _onItemTapped(context, index),
//       destinations: _destinations
//           .map((dest) => NavigationDestination(
//         icon: Icon(dest.$1, color: const Color(0xFFE01312), size: 24),
//         selectedIcon: Icon(dest.$2, color: const Color(0xFFE01312), size: 24),
//         label: dest.$3,
//       ))
//           .toList(),
//     );
//   }
// }