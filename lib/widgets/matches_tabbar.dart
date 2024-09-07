import 'package:flutter/material.dart';

class MatchTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  const MatchTabAppBar({required this.tabController, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Cric Scores', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
      centerTitle: true,
      bottom: TabBar(
        labelColor: Colors.black,
        labelStyle: TextStyle(fontSize: 22),
        controller: tabController,
        tabs: [
          Tab(text: 'Live'),
          Tab(text: 'Upcoming'),
          Tab(text: 'Completed'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48.0);
}
