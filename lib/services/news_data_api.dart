import 'dart:convert';
import 'package:cricklyzer/models/news_model.dart';
import 'package:http/http.dart' as http;

Future<List<NewsArticle>> fetchCricketNews() async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=961e4cc1d515499c874dcc9ee2305c96'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['articles'];
    return data.map((json) => NewsArticle.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load news');
  }
}
