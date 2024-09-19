import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cricklyzer/screens/learning_screens/batting_tips.dart';

class CricketBasics extends StatelessWidget {
  const CricketBasics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Basics of Cricket'),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: Center(
        child: Text('Welcome to Cricket Basics!'),
      ),
    );
  }
}

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.white,
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xffcf2e2e),
          ),
          child: Center(
            child: Text(
              '🏏',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('10 Fundamental Cricket Basics To Help Your Game'),
          onTap: () async {
            final url = Uri.parse('https://villagecricket.co/cricket-basics/');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: Icon(Icons.book),
          title: Text('Understand Basic Rules'),
          onTap: () async {
            final url = Uri.parse('https://www.wikihow.com/Understand-the-Basic-Rules-of-Cricket');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: Icon(Icons.games),
          title: Text('How to Play the Game'),
          onTap: () async {
            final url = Uri.parse('https://www.wikihow.com/Play-Cricket');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: Icon(Icons.sports_cricket_rounded),
          title: Text('Improve Your Batting'),
          onTap: () async {
            final url = Uri.parse('https://www.wikihow.com/Improve-Your-Batting-in-Cricket');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: Icon(Icons.speed),
          title: Text('How to Bowl Fast in Cricket'),
          onTap: () async {
            final url = Uri.parse('https://www.wikihow.com/Bowl-Fast-in-Cricket');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: Icon(Icons.find_replace),
          title: Text('How to Replace a Cricket Bat Grip'),
          onTap: () async {
            final url = Uri.parse('https://www.wikihow.com/Replace-a-Cricket-Bat-Grip');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: Icon(Icons.sports_handball_sharp),
          title: Text('How to Reverse Swing a Cricket Ball'),
          onTap: () async {
            final url = Uri.parse('https://www.wikihow.com/Reverse-Swing-a-Cricket-Ball');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: Icon(Icons.backpack),
          title: Text('How to Dress for Cricket'),
          onTap: () async {
            final url = Uri.parse('https://www.wikihow.com/Dress-for-Cricket');
            await launchUrl(url);
          },
        ),

      ],
    ),
  );
}




































