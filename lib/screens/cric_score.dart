import 'package:cricklyzer/widgets/appbar.dart';
import 'package:cricklyzer/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class CricScore extends StatelessWidget {
  const CricScore({Key? key}) : super(key: key);
  final int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2.5 - 100,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Scores will be displayed here', style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavigationBar(selectedIndex: _selectedIndex,),
          ),
        ],
      ),
    );
  }
}

