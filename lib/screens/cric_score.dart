// import 'package:cricklyzer/services/cric_api_service.dart';
// import 'package:cricklyzer/widgets/appbar.dart';
// import 'package:cricklyzer/widgets/bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';
//
// class CricScore extends StatefulWidget {
//   const CricScore({super.key});
//
//   @override
//   _CricScoreState createState() => _CricScoreState();
// }
//
// class _CricScoreState extends State<CricScore> {
//   late CricApiService _cricApiService;
//   late Future<List<dynamic>> _liveScores;
//
//   @override
//   void initState() {
//     super.initState();
//     _cricApiService = CricApiService();
//     _liveScores = _cricApiService.fetchLiveScores();
//   }
//   final _selectedIndex = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
//       appBar: CustomAppBar(),
//       body: FutureBuilder<List<dynamic>>(
//         future: _liveScores,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No live matches available'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final match = snapshot.data![index];
//                 return ListTile(
//                   title: Text('${match['t1']} vs ${match['t2']}'),
//                   subtitle: Text(match['series']),
//                   trailing: Text(match['status']),
//                   onTap: () {
//                     // Handle match details tap
//                     // Arrange the match list in the sequence -> Live, Upcoming, Completed
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }







































// import 'package:cricklyzer/services/cric_api_service.dart';
// import 'package:cricklyzer/widgets/appbar.dart';
// import 'package:cricklyzer/widgets/bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';
//
// class CricScore extends StatefulWidget {
//   const CricScore({super.key});
//
//   @override
//   _CricScoreState createState() => _CricScoreState();
// }
//
// class _CricScoreState extends State<CricScore> {
//   late CricApiService _cricApiService;
//   late Future<Map<String, List<dynamic>>> _categorizedMatches;
//
//   @override
//   void initState() {
//     super.initState();
//     _cricApiService = CricApiService();
//     _categorizedMatches = _cricApiService.fetchCategorizedMatches();
//   }
//
//   final _selectedIndex = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
//       appBar: CustomAppBar(),
//       body: FutureBuilder<Map<String, List<dynamic>>>(
//         future: _categorizedMatches,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No matches available'));
//           } else {
//             final liveMatches = snapshot.data!['Live']!;
//             final upcomingMatches = snapshot.data!['Upcoming']!;
//             final completedMatches = snapshot.data!['Completed']!;
//
//             return ListView(
//               children: [
//                 if (liveMatches.isNotEmpty)
//                   _buildMatchSection('Live Matches', liveMatches),
//                 if (upcomingMatches.isNotEmpty)
//                   _buildMatchSection('Upcoming Matches', upcomingMatches),
//                 if (completedMatches.isNotEmpty)
//                   _buildMatchSection('Completed Matches', completedMatches),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildMatchSection(String title, List<dynamic> matches) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: matches.length,
//             itemBuilder: (context, index) {
//               final match = matches[index];
//               return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 elevation: 3,
//                 child: ListTile(
//                   title: Text('${match['t1']} vs ${match['t2']}'),
//                   subtitle: Text(match['series']),
//                   trailing: Text(match['status']),
//                   onTap: () {
//                     // Handle match details tap
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:cricklyzer/screens/matchdetails_screen.dart';
import 'package:cricklyzer/services/cric_api_service.dart';
import 'package:cricklyzer/widgets/bottom_navigation_bar.dart';
import 'package:cricklyzer/widgets/matches_tabbar.dart';
import 'package:flutter/material.dart';

class CricScore extends StatefulWidget {
  const CricScore({super.key});

  @override
  _CricScoreState createState() => _CricScoreState();
}

class _CricScoreState extends State<CricScore> with SingleTickerProviderStateMixin {
  late CricApiService _cricApiService;
  late Future<Map<String, List<dynamic>>> _categorizedMatches;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _cricApiService = CricApiService();
    _categorizedMatches = _fetchCategorizedMatches();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<Map<String, List<dynamic>>> _fetchCategorizedMatches() async {
    return await _cricApiService.fetchCategorizedMatches();
  }

  final _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
      appBar: MatchTabAppBar(tabController: _tabController),
      body: FutureBuilder<Map<String, List<dynamic>>>(
        future: _categorizedMatches,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xffcf2e2e),));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No matches available'));
          } else {
            final liveMatches = snapshot.data!['Live']!;
            final upcomingMatches = snapshot.data!['Upcoming']!;
            final completedMatches = snapshot.data!['Completed']!;

            return TabBarView(
              controller: _tabController,
              children: [
                _buildMatchList(liveMatches),
                _buildMatchList(upcomingMatches),
                _buildMatchList(completedMatches),
              ],
            );
          }
        },
      ),
    );
  }


  Widget _buildMatchList(List<dynamic> matches) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _categorizedMatches = _fetchCategorizedMatches();
        });
      },
      child: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return Card(
            color: Colors.black,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 3,
            child: ListTile(
              title: Text('${match['t1']} vs ${match['t2']}', style: const TextStyle(color: Colors.white)),
              subtitle: Text(match['series'], style: const TextStyle(color: Colors.white54)),
              trailing: Text(match['status'], style: const TextStyle(color: Colors.white54)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MatchDetailsScreen(matchId: match['id']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }



// Widget _buildMatchList(List<dynamic> matches) {
  //   return RefreshIndicator(
  //     onRefresh: () async {
  //       setState(() {
  //         _categorizedMatches = _fetchCategorizedMatches();
  //       });
  //     },
  //     child: ListView.builder(
  //       itemCount: matches.length,
  //       itemBuilder: (context, index) {
  //         final match = matches[index];
  //         return Card(
  //           color: Colors.black,
  //           margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //           elevation: 3,
  //           child: ListTile(
  //             title: Text('${match['t1']} vs ${match['t2']}', style: TextStyle(color: Colors.white),),
  //             subtitle: Text(match['series'], style: TextStyle(color: Colors.white54),),
  //             trailing: Text(match['status'], style: TextStyle(color: Colors.white54),),
  //             onTap: () {
  //               // Handle match details tap
  //             },
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
