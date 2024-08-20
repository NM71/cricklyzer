import 'package:cricklyzer/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:cricklyzer/widgets/bottom_navigation_bar.dart';
import '../widgets/simple_card_widget.dart';
import '../widgets/user_profile_bottom_sheet.dart';

class LearningHub extends StatelessWidget {
  const LearningHub({super.key});
  final int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                null;
              },
              child: const CardWidget(
                title: 'Fast Bowling Drill/Exercises',
                imagePath: 'assets/images/Brett-Lee-ODI.jpg',
                width: 300,
                height: 220,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                null;
              },
              child: const CardWidget(
                title: 'Spinners Drills/Exercises',
                imagePath: 'assets/spinners_image.jpg',
                width: 300,
                height: 220,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

