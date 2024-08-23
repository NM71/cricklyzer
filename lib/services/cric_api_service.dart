import 'dart:convert';
import 'package:http/http.dart' as http;

class CricApiService {
  final String _apiKey = "f938ec09-f32c-4c7e-97f1-1b752904a40e";
  final String _baseUrl = "https://api.cricapi.com/v1/cricScore";
  final String _matchInfoUrl = "https://api.cricapi.com/v1/match_info";

  // Existing method to fetch categorized matches
  Future<Map<String, List<dynamic>>> fetchCategorizedMatches() async {
    final response = await http.get(Uri.parse('$_baseUrl?apikey=$_apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];

      final liveMatches = <dynamic>[];
      final upcomingMatches = <dynamic>[];
      final completedMatches = <dynamic>[];

      for (var match in data) {
        final status = match['status'].toLowerCase();
        if (status.contains('live')) {
          liveMatches.add(match);
        } else if (status.contains('upcoming') || status.contains('not started')) {
          upcomingMatches.add(match);
        } else {
          completedMatches.add(match);
        }
      }
      return {
        'Live': liveMatches,
        'Upcoming': upcomingMatches,
        'Completed': completedMatches,
      };
    } else {
      throw Exception('Failed to load matches');
    }
  }

  // Fetching match details
  Future<Map<String, dynamic>> fetchMatchInfo(String matchId) async {
    final response = await http.get(Uri.parse('$_matchInfoUrl?apikey=$_apiKey&id=$matchId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load match details');
    }
  }
}















































// old code 1
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class CricApiService {
//   final String _apiKey = "f938ec09-f32c-4c7e-97f1-1b752904a40e";
//   final String _baseUrl = "https://api.cricapi.com/v1/cricScore";
//
//   Future<List<dynamic>> fetchLiveScores() async {
//     final response = await http.get(Uri.parse('$_baseUrl?apikey=$_apiKey'));
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['data'];
//     } else {
//       throw Exception('Failed to load live scores');
//     }
//   }
// }



// old code 2
// class CricApiService {
//   final String _apiKey = "f938ec09-f32c-4c7e-97f1-1b752904a40e";
//   final String _baseUrl = "https://api.cricapi.com/v1/cricScore";
//
//   Future<Map<String, List<dynamic>>> fetchCategorizedMatches() async {
//     final response = await http.get(Uri.parse('$_baseUrl?apikey=$_apiKey'));
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body)['data'];
//
//       final liveMatches = <dynamic>[];
//       final upcomingMatches = <dynamic>[];
//       final completedMatches = <dynamic>[];
//
//       for (var match in data) {
//         final status = match['status'].toLowerCase();
//         if (status.contains('live')) {
//           liveMatches.add(match);
//         } else if (status.contains('upcoming') || status.contains('not started')) {
//           upcomingMatches.add(match);
//         } else {
//           completedMatches.add(match);
//         }
//       }
//
//       return {
//         'Live': liveMatches,
//         'Upcoming': upcomingMatches,
//         'Completed': completedMatches,
//       };
//     } else {
//       throw Exception('Failed to load matches');
//     }
//   }
// }
