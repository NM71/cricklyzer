import 'package:flutter/material.dart';
import 'package:cricklyzer/services/cric_api_service.dart';

class MatchDetailsScreen extends StatelessWidget {
  final String matchId;

  const MatchDetailsScreen({required this.matchId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CricApiService cricApiService = CricApiService();

    return Scaffold(
      appBar: AppBar(title: const Text('Match Details')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: cricApiService.fetchMatchInfo(matchId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xffe01312),));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No match details available'));
          } else {
            final match = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    match['name'],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text('Venue: ${match['venue']}'),
                  Text('Date: ${match['date']}'),
                  Text('Match Type: ${match['matchType']}'),
                  const SizedBox(height: 16),
                  Text('Teams:', style: const TextStyle(fontWeight: FontWeight.bold)),
                  for (var team in match['teamInfo'])
                    ListTile(
                      leading: Image.network(team['img']),
                      title: Text(team['name']),
                      subtitle: Text(team['shortname']),
                    ),
                  const SizedBox(height: 16),
                  Text('Score:', style: const TextStyle(fontWeight: FontWeight.bold)),
                  for (var score in match['score'])
                    Text('${score['inning']}: ${score['r']}/${score['w']} in ${score['o']} overs'),
                  const SizedBox(height: 16),
                  Text('Status: ${match['status']}'),
                  Text('Toss: ${match['tossWinner']} won the toss and chose to ${match['tossChoice']}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
