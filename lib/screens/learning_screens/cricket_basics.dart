import 'package:cricklyzer/screens/learning_screens/batting_tips.dart';
import 'package:flutter/material.dart';

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



class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Settings'),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: Center(
        child: Text('Settings screen content'),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('About'),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: Center(
        child: Text('About screen content'),
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
            color: Color(0xffe01312),
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
          title: Text('Cricket Basics'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CricketBasics()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.sports_cricket_rounded),
          title: Text('Improve Your Batting'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BattingTips()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('About'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AboutScreen()),
            );
          },
        ),
      ],
    ),
  );
}