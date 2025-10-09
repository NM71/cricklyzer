import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:cricklyzer/widgets/appbar.dart';
import 'package:cricklyzer/widgets/bottom_navigation_bar.dart';
import 'package:cricklyzer/widgets/shimmer_widgets.dart';
import 'package:cricklyzer/services/api_service.dart';

class CricketNewsScreen extends StatefulWidget {
  const CricketNewsScreen({super.key});

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

  Future<void> fetchRssFeed({bool forceRefresh = false}) async {
    setState(() {
      isLoading = true;
    });

    try {
      final dio = await ApiService.getInstance();
      final response = forceRefresh
          ? await ApiService.forceRefresh(
              'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.espncricinfo.com%2Frss%2Fcontent%2Fstory%2Ffeeds%2F0.xml')
          : await dio.get(
              'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.espncricinfo.com%2Frss%2Fcontent%2Fstory%2Ffeeds%2F0.xml');

      final data = response.data;
      if (data['status'] == 'ok') {
        setState(() {
          newsItems = List<Map<String, dynamic>>.from(data['items']);
        });
      } else {
        throw Exception('Failed to load RSS feed');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading news')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    await fetchRssFeed(forceRefresh: true);
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
      appBar: CustomAppBar(onRefresh: _refreshData),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: RefreshIndicator(
            onRefresh: () => fetchRssFeed(forceRefresh: true),
            child: isLoading
                ? ShimmerListView(itemCount: 5)
                : ListView.builder(
                    itemCount: newsItems.length,
                    itemBuilder: (context, index) {
                      final item = newsItems[index];
                      String imageUrl = '';

                      // Get image URL
                      if (item['enclosure'] != null &&
                          item['enclosure']['link'] != null) {
                        imageUrl = item['enclosure']['link'] as String;
                      }

                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () => _launchURL(item['link'] ?? ''),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (imageUrl.isNotEmpty)
                                Image.network(
                                  imageUrl,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      height: 200,
                                      color: Colors.grey[200],
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: Color(0xffcf2e2e),
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 200,
                                      color: Colors.grey[200],
                                      child: const Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey,
                                          size: 40,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(item['description'] ?? ''),
                                    const SizedBox(height: 8),
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
      ),
    );
  }
}
