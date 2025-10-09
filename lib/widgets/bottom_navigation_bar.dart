import 'package:flutter/material.dart';
import 'package:cricklyzer/screens/calculate_pace.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange,
  }) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 4), // Slow rotation for elegance
      vsync: this,
    )..repeat(); // Continuous rotation
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 80, // Increased height to fully accommodate center button
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none, // Allow content to overflow
        children: [
          // Bottom Navigation Bar with transparent background
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 20, // Leave space for center button
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                selectedItemColor: const Color(0xffcf2e2e),
                unselectedItemColor: Colors.grey,
                currentIndex: widget.selectedIndex,
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.insert_chart_outlined),
                    activeIcon: Icon(Icons.insert_chart),
                    label: 'Stats',
                  ),
                ],
                onTap: widget.onTabChange,
              ),
            ),
          ),
          // Center Logo Button
          Positioned(
            left: 0,
            right: 0,
            top: -5, // Position to show completely above nav bar
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xffcf2e2e),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Navigate to Calculate Pace screen
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CalculatePace(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: RotationTransition(
                          turns: _rotationController,
                          child: Image.asset(
                            'assets/images/Cricklyzer-logo-2-black.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



















// import 'package:cricklyzer/screens/cric_coverage.dart';
// import 'package:cricklyzer/Screens/learning_hub.dart';
// import 'package:cricklyzer/Screens/home_screen.dart';
// import 'package:cricklyzer/Screens/statistics_screen.dart';
// import 'package:flutter/material.dart';
//
// class CustomBottomNavigationBar extends StatelessWidget {
//   final int selectedIndex;
//   const CustomBottomNavigationBar({Key? key, required this.selectedIndex}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: Colors.white,
//       selectedItemColor: const Color(0xffcf2e2e),
//       unselectedItemColor: Colors.grey,
//       currentIndex: selectedIndex,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_outlined),
//           activeIcon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.local_convenience_store_outlined),
//           activeIcon: Icon(Icons.scoreboard),
//           label: 'Coverage',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.insert_chart_outlined),
//           activeIcon: Icon(Icons.insert_chart),
//           label: 'Stats',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.sports_cricket_outlined),
//           activeIcon: Icon(Icons.sports_cricket),
//           label: 'Learn Hub',
//         ),
//       ],
//       onTap: (index) {
//         switch (index) {
//           case 0:
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => HomeScreen()),
//             );
//             break;
//           case 1:
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const CricketCoverage()),
//             );
//             break;
//           case 2:
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const StatisticsScreen()),
//             );
//             break;
//           case 3:
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const LearningHub()),
//             );
//             break;
//         }
//       },
//     );
//   }
// }
//































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
//           icon: Icon(Icons.home_outlined, color: Color(0xffcf2e2e), size: 24,),
//           selectedIcon: Icon(Icons.home, color: Color(0xffcf2e2e), size: 24,),
//           label: 'Home',
//         ),
//         NavigationDestination(
//           icon: Icon(Icons.local_convenience_store_outlined, color: Color(0xffcf2e2e), size: 24,),
//           selectedIcon: Icon(Icons.scoreboard, color: Color(0xffcf2e2e), size: 24,),
//           label: 'Coverage',
//         ),
//         NavigationDestination(
//           icon: Icon(Icons.insert_chart_outlined,color: Color(0xffcf2e2e), size: 24,),
//           selectedIcon: Icon(Icons.insert_chart,color: Color(0xffcf2e2e), size: 24,),
//           label: 'Stats',
//         ),
//         NavigationDestination(
//           icon: Icon(Icons.sports_cricket_outlined,color: Color(0xffcf2e2e), size: 25,),
//           selectedIcon: Icon(Icons.sports_cricket,color: Color(0xffcf2e2e), size: 25,),
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
//         icon: Icon(dest.$1, color: const Color(0xffcf2e2e), size: 24),
//         selectedIcon: Icon(dest.$2, color: const Color(0xffcf2e2e), size: 24),
//         label: dest.$3,
//       ))
//           .toList(),
//     );
//   }
// }
