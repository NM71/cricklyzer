import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:url_launcher/url_launcher.dart';

class LiveScoresWidget extends StatefulWidget {
  @override
  _LiveScoresWidgetState createState() => _LiveScoresWidgetState();
}

class _LiveScoresWidgetState extends State<LiveScoresWidget> {
  List<Map<String, String>> liveScores = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLiveScores();
  }

  Future<void> fetchLiveScores() async {
    try {
      final response = await http.get(Uri.parse('https://www.espncricinfo.com/rss/livescores.xml'));
      if (response.statusCode == 200) {
        final document = xml.XmlDocument.parse(response.body);
        final items = document.findAllElements('item');

        setState(() {
          liveScores = items.map((item) {
            return {
              'title': item.findElements('title').single.innerText,
              'link': item.findElements('link').single.innerText,
              'description': item.findElements('description').single.innerText,
            };
          }).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load live scores');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading live scores: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Text(
            'Live Scores',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xffe01312)))
            : Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: liveScores.length,
            itemBuilder: (context, index) {
              final score = liveScores[index];
              return GestureDetector(
                onTap: () => _launchURL(score['link'] ?? ''),
                child: Card(
                  color: Color(0xffffffff),
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          score['title'] ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          score['description'] ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}