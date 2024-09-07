import 'package:cricklyzer/screens/learning_screens/cricket_basics.dart';
import 'package:cricklyzer/screens/pdf_viewer_screen.dart';
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
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewerScreen()));
                  },
                  child: CardWidget(
                    title: 'ICC Playing Handbook 2019-20',
                    imagePath: 'assets/ICC PHB.png',
                    width: MediaQuery.sizeOf(context).width*0.8,
                    height: MediaQuery.sizeOf(context).height*0.5,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CricketBasics()));

                  },
                  child: CardWidget(
                    title: 'Basics of Cricket',
                    imagePath: 'assets/images/cricket_learn_image.png',
                    width: MediaQuery.sizeOf(context).width*0.8,
                    height: MediaQuery.sizeOf(context).height*0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

