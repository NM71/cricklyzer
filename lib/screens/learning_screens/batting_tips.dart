import 'package:cricklyzer/screens/learning_screens/cricket_basics.dart';
import 'package:flutter/material.dart';

class BattingTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Improve Your Batting'),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            'Improve Your Batting in Cricket',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          buildTipSection(
            title: '1. Getting into Position',
            content: 'Take a firm grip on the bat with both hands. Assume a comfortable stance '
                'and be ready to adjust during games. Hold the bat at waist height until it’s time to swing.',
          ),
          buildTipSection(
            title: '2. Delivering a Proper Swing',
            content: 'As the bowler delivers the ball, begin lifting the bat. Swing straight to meet the ball '
                'and follow through for more distance.',
          ),
          buildTipSection(
            title: '3. Hitting with More Success',
            content: 'Study the bowler for clues and keep your eye on the ball. '
                'Wait for the perfect moment to swing and maximize your scoring potential.',
          ),
          buildTipSection(
            title: '4. Stepping up Your Game',
            content: 'Practice regularly to improve your skills. Focus on both technique and fitness, '
                'and refine your strengths to perform under pressure.',
          ),
        ],
      ),
    );
  }

  Widget buildTipSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}