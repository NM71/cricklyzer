import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class CricketNewsScreen extends StatefulWidget {
  @override
  _CricketNewsScreenState createState() => _CricketNewsScreenState();
}

class _CricketNewsScreenState extends State<CricketNewsScreen> {
  List<Map<String, dynamic>> newsItems = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchRssFeed();
  }

  Future<void> fetchRssFeed() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.espncricinfo.com%2Frss%2Fcontent%2Fstory%2Ffeeds%2F0.xml'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'ok') {
          setState(() {
            newsItems = List<Map<String, dynamic>>.from(data['items']);
          });
        } else {
          throw Exception('Failed to load RSS feed: ${data['message']}');
        }
      } else {
        throw Exception('Failed to load RSS feed');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading news: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  String _formatDate(String dateString) {
    final dateTime = DateTime.parse(dateString);
    return DateFormat('MMM d, yyyy - h:mm a').format(dateTime.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        title: Text('News Feed'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: RefreshIndicator(
          onRefresh: fetchRssFeed,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Color(0xffe01312),
                ))
              : ListView.builder(
                  itemCount: newsItems.length,
                  itemBuilder: (context, index) {
                    final item = newsItems[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () => _launchURL(item['link'] ?? ''),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item['enclosure'] != null &&
                                item['enclosure']['link'] != null)
                              Image.network(
                                item['enclosure']['link'],
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'] ?? '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(item['description'] ?? ''),
                                  SizedBox(height: 8),
                                  Text(
                                    _formatDate(item['pubDate'] ?? ''),
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
