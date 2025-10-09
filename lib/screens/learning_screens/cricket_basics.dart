import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cricklyzer/screens/learning_screens/batting_tips.dart';

class CricketBasics extends StatelessWidget {
  const CricketBasics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Basics of Cricket'),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: const Center(
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
        const DrawerHeader(
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
          leading: const Icon(Icons.home),
          title: const Text('10 Fundamental Cricket Basics To Help Your Game'),
          onTap: () async {
            final url = Uri.parse('https://villagecricket.co/cricket-basics/');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Understand Basic Rules'),
          onTap: () async {
            final url = Uri.parse(
                'https://www.wikihow.com/Understand-the-Basic-Rules-of-Cricket');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: const Icon(Icons.games),
          title: const Text('How to Play the Game'),
          onTap: () async {
            final url = Uri.parse('https://www.wikihow.com/Play-Cricket');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports_cricket_rounded),
          title: const Text('Improve Your Batting'),
          onTap: () async {
            final url = Uri.parse(
                'https://www.wikihow.com/Improve-Your-Batting-in-Cricket');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: const Icon(Icons.speed),
          title: const Text('How to Bowl Fast in Cricket'),
          onTap: () async {
            final url =
                Uri.parse('https://www.wikihow.com/Bowl-Fast-in-Cricket');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: const Icon(Icons.find_replace),
          title: const Text('How to Replace a Cricket Bat Grip'),
          onTap: () async {
            final url =
                Uri.parse('https://www.wikihow.com/Replace-a-Cricket-Bat-Grip');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports_handball_sharp),
          title: const Text('How to Reverse Swing a Cricket Ball'),
          onTap: () async {
            final url = Uri.parse(
                'https://www.wikihow.com/Reverse-Swing-a-Cricket-Ball');
            await launchUrl(url);
          },
        ),
        ListTile(
          leading: const Icon(Icons.backpack),
          title: const Text('How to Dress for Cricket'),
          onTap: () async {
            final url = Uri.parse('https://www.wikihow.com/Dress-for-Cricket');
            await launchUrl(url);
          },
        ),
      ],
    ),
  );
}
