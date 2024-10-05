//
//
// // -----------------------------------------
//
// import 'package:cricklyzer/Screens/calculate_pace.dart';
// import 'package:cricklyzer/widgets/appbar.dart';
// import 'package:cricklyzer/widgets/custom_buttons.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cricklyzer/widgets/bottom_navigation_bar.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';
//
// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<Map<String, dynamic>> newsItems = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchRssFeed();
//   }
//
//   Future<void> fetchRssFeed() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.espncricinfo.com%2Frss%2Fcontent%2Fstory%2Ffeeds%2F0.xml'));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['status'] == 'ok') {
//           setState(() {
//             newsItems = List<Map<String, dynamic>>.from(data['items']);
//             isLoading = false;
//           });
//         } else {
//           throw Exception('Failed to load RSS feed: ${data['message']}');
//         }
//       } else {
//         throw Exception('Failed to load RSS feed');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error loading news: $e')),
//       );
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   String _formatDate(String dateString) {
//     final dateTime = DateTime.parse(dateString);
//     return DateFormat('MMM d, yyyy - h:mm a').format(dateTime.toLocal());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const selectedIndex = 0;
//     User? user = FirebaseAuth.instance.currentUser;
//
//     return Scaffold(
//       appBar: CustomAppBar(),
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               color: Color(0xffffffff),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                   child: Text(
//                     'Welcome, ${user?.displayName ?? "Guest User"}',
//                     style: const TextStyle(
//                       fontSize: 24,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 isLoading
//                     ? const Center(child: CircularProgressIndicator())
//                     : CarouselSlider.builder(
//                   itemCount: newsItems.length,
//                   options: CarouselOptions(
//                     height: MediaQuery.of(context).size.height * 0.3,
//                     autoPlay: true,
//                     autoPlayInterval: const Duration(seconds: 3),
//                     autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     enlargeCenterPage: true,
//                     viewportFraction: 0.9,
//                   ),
//                   itemBuilder: (context, index, realIndex) {
//                     final item = newsItems[index];
//                     final imageUrl = item['enclosure']?['link'] ?? 'https://via.placeholder.com/300x200?text=No+Image';
//
//                     return GestureDetector(
//                       onTap: () => _launchURL(item['link'] ?? ''),
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         child: Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(15.0),
//                               child: Image.network(
//                                 imageUrl,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return Center(child: Text('Failed to load image'));
//                                 },
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     item['title'] ?? '',
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     _formatDate(item['pubDate'] ?? ''),
//                                     style: const TextStyle(
//                                       color: Colors.white70,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 30),
//                 Center(
//                   child: Column(
//                     children: [
//                       const Text(
//                         'Want to know your Pace?',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       CustomButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const CalculatePace(),
//                             ),
//                           );
//                         },
//                         text: 'Calculate Pace',
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: CustomBottomNavigationBar(selectedIndex: selectedIndex),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// //--------------------------------------------
//
//

//-----------------------------------------------------------
// home_screen.dart
// import 'package:cricklyzer/Screens/calculate_pace.dart';
// import 'package:cricklyzer/Screens/statistics_screen.dart';
// import 'package:cricklyzer/widgets/live_scores.dart';
// import 'package:cricklyzer/widgets/animated_FAB.dart';
// import 'package:cricklyzer/widgets/appbar.dart';
// import 'package:cricklyzer/widgets/custom_buttons.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cricklyzer/widgets/bottom_navigation_bar.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';
//
// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<Map<String, dynamic>> newsItems = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchRssFeed();
//   }
//
//   Future<void> fetchRssFeed() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.espncricinfo.com%2Frss%2Fcontent%2Fstory%2Ffeeds%2F0.xml'));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['status'] == 'ok') {
//           setState(() {
//             newsItems = List<Map<String, dynamic>>.from(data['items']);
//             isLoading = false;
//           });
//         } else {
//           throw Exception('Failed to load RSS feed: ${data['message']}');
//         }
//       } else {
//         throw Exception('Failed to load RSS feed');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error loading news: $e')),
//       );
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   String _formatDate(String dateString) {
//     final dateTime = DateTime.parse(dateString);
//     return DateFormat('MMM d, yyyy - h:mm a').format(dateTime.toLocal());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const selectedIndex = 0;
//     User? user = FirebaseAuth.instance.currentUser;
//
//     return Scaffold(
//       appBar: CustomAppBar(),
//       body: Container(
//         decoration: const BoxDecoration(
//           color: Color(0xffffffff),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Padding(
//                     //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                     //   child: Row(
//                     //     children: [
//                     //       Text(
//                     //         'Welcome, ',
//                     //         style: const TextStyle(
//                     //           fontSize: 14,
//                     //           color: Colors.black,
//                     //         ),
//                     //       ),
//                     //       Text(
//                     //         '${user?.displayName ?? "Guest User"}',
//                     //         style: const TextStyle(
//                     //           fontSize: 16,
//                     //           color: Colors.black,
//                     //           fontWeight: FontWeight.bold,
//                     //         ),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                       child: Text(
//                         'Your Pace Record',
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                       ),
//                     ),
//                     SpeedBoxes(),
//                     Column(
//                       children: [
//                         LiveScoresWidget(),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                       child: Text(
//                         'Top News',
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     isLoading
//                         ? const Center(
//                         child: CircularProgressIndicator(
//                           color: Color(0xffcf2e2e),
//                         ))
//                         : CarouselSlider.builder(
//                       itemCount: newsItems.length,
//                       options: CarouselOptions(
//                         height: MediaQuery.of(context).size.height * 0.3,
//                         autoPlay: true,
//                         autoPlayInterval: const Duration(seconds: 3),
//                         autoPlayAnimationDuration: const Duration(milliseconds: 1000),
//                         autoPlayCurve: Curves.fastOutSlowIn,
//                         enlargeCenterPage: true,
//                         viewportFraction: 0.9,
//                       ),
//                       itemBuilder: (context, index, realIndex) {
//                         final item = newsItems[index];
//                         final imageUrl = (item['enclosure'] != null &&
//                             item['enclosure']['link'] != null)
//                             ? item['enclosure']['link']
//                             .replaceFirst('http://', 'https://')
//                             : 'https://via.placeholder.com/300x200?text=No+Image';
//
//                         return GestureDetector(
//                           onTap: () => _launchURL(item['link'] ?? ''),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                             child: Stack(
//                               fit: StackFit.expand,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                   child: Image.network(
//                                     imageUrl,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Center(child: Text('Failed to load image'));
//                                     },
//                                   ),
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15.0),
//                                     gradient: LinearGradient(
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                       colors: [
//                                         Colors.transparent,
//                                         Colors.black.withOpacity(0.7)
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         item['title'] ?? '',
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         _formatDate(item['pubDate'] ?? ''),
//                                         style: const TextStyle(
//                                           color: Colors.white70,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: selectedIndex),
//       floatingActionButton: FloatingActionAnimation(),
//     );
//   }
// }











































import 'package:cricklyzer/Screens/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

// Import your custom widgets
import 'package:cricklyzer/widgets/live_scores.dart';
import 'package:cricklyzer/widgets/animated_FAB.dart';
import 'package:cricklyzer/widgets/appbar.dart';
import 'package:cricklyzer/widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> newsItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRssFeed();
  }

  Future<void> fetchRssFeed() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.espncricinfo.com%2Frss%2Fcontent%2Fstory%2Ffeeds%2F0.xml'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'ok') {
          setState(() {
            newsItems = List<Map<String, dynamic>>.from(data['items']);
            isLoading = false;
          });
        } else {
          // throw Exception('Failed to load RSS feed: ${data['message']}');
          throw Exception('Failed to load RSS feed');
        }
      } else {
        throw Exception('Failed to load RSS feed');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        // SnackBar(content: Text('Error loading news: $e')),
        const SnackBar(content: Text('Error loading news')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void _openWebView(String url, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebViewScreen(url: url, title: title),
      ),
    );
  }

  String _formatDate(String dateString) {
    final dateTime = DateTime.parse(dateString);
    return DateFormat('MMM d, yyyy - h:mm a').format(dateTime.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    const selectedIndex = 0;
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Text(
                        'Your Pace Record',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const SpeedBoxes(),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Text(
                        'Top News',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 10),
                    isLoading
                        ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffcf2e2e),
                        ))
                        : CarouselSlider.builder(
                      itemCount: newsItems.length,
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.3,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final item = newsItems[index];
                        final imageUrl = (item['enclosure'] != null &&
                            item['enclosure']['link'] != null)
                            ? item['enclosure']['link']
                            .replaceFirst('http://', 'https://')
                            : 'https://via.placeholder.com/300x200?text=No+Image';

                        return GestureDetector(
                          onTap: () => _openWebView(item['link'] ?? '', 'News'),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(child: Text('Failed to load image'));
                                    },
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.7)
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _formatDate(item['pubDate'] ?? ''),
                                        style: const TextStyle(
                                          color: Colors.white70,
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
                    Column(
                      children: [
                        LiveScoresWidget(
                          onTap: (url) => _openWebView(url, 'Live Scores'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: selectedIndex),
      floatingActionButton: FloatingActionAnimation(),
    );
  }
}

class WebViewScreen extends StatelessWidget {
  final String url;
  final String title;

  const WebViewScreen({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(url)),
      ),
    );
  }
}