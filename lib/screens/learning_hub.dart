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
      backgroundColor: Color(0xffffffff),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
      appBar: CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  null;
                },
                child: CardWidget(
                  title: 'Fast Bowling Drill/Exercises',
                  imagePath: 'assets/images/Brett-Lee-ODI.jpg',
                  width: MediaQuery.sizeOf(context).width*0.6,
                  height: MediaQuery.sizeOf(context).height*0.3,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  null;
                },
                child: CardWidget(
                  title: 'Spinners Drills/Exercises',
                  imagePath: 'assets/spinners_image.jpg',
                  width: MediaQuery.sizeOf(context).width*0.6,
                  height: MediaQuery.sizeOf(context).height*0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

