import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({Key? key}) : super(key: key);

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final String assetPath = "assets/ICC Playing Handbook 2019-20.pdf";
  PdfViewerController _pdfViewerController = PdfViewerController();
  final TextEditingController _pageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  int _totalPages = 0; // To store the total number of pages
  int _currentPage = 0; // To store the current page number
  PdfTextSearchResult _searchResult = PdfTextSearchResult(); // To store search results

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ICC Handbook'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SfPdfViewer.asset(
            assetPath,
            controller: _pdfViewerController,
            enableDoubleTapZooming: true,
            pageLayoutMode: PdfPageLayoutMode.continuous,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                _totalPages = details.document.pages.count;
                _currentPage = 1;
              });
            },
            onPageChanged: (PdfPageChangedDetails details) {
              setState(() {
                _currentPage = details.newPageNumber;
              });
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Page $_currentPage of $_totalPages',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _searchResult.totalInstanceCount > 0
          ? _buildSearchNavigation()
          : SizedBox.shrink(),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Search Topic"),
          content: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Enter topic or text to search", // Hinted text for search
            ),
          ),
          actions: [
            TextButton(
              child: Text("Search"),
              onPressed: () async {
                if (_searchController.text.isNotEmpty) {
                  _searchResult = await _pdfViewerController.searchText(_searchController.text);
                  if (_searchResult.totalInstanceCount == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("No results found for '${_searchController.text}'")),
                    );
                  } else {
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Navigation for search results (Next and Previous)
  Widget _buildSearchNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () {
            if (_searchResult.currentInstanceIndex > 1) {
              _searchResult.previousInstance(); // Navigate to previous search result
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("No previous results")),
              );
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.navigate_next),
          onPressed: () {
            if (_searchResult.currentInstanceIndex < _searchResult.totalInstanceCount) {
              _searchResult.nextInstance(); // Navigate to next search result
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("No more results")),
              );
            }
          },
        ),
      ],
    );
  }

  // Method to show dialog for entering a page number to navigate to
  void _showGoToPageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Go to Page"),
          content: TextField(
            controller: _pageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter page number (1-$_totalPages)", // Display the total number of pages as a hint
            ),
          ),
          actions: [
            TextButton(
              child: Text("Go"),
              onPressed: () {
                int? page = int.tryParse(_pageController.text);
                if (page == null || page < 1 || page > _totalPages) {
                  // Handle out-of-range or invalid input
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a valid page number between 1 and $_totalPages.")),
                  );
                } else {
                  _pdfViewerController.jumpToPage(page);
                  Navigator.of(context).pop(); // Close the dialog after navigating to the page
                }
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without action
              },
            ),
          ],
        );
      },
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class PdfViewerScreen extends StatefulWidget {
//   const PdfViewerScreen({Key? key}) : super(key: key);
//
//   @override
//   _PdfViewerScreenState createState() => _PdfViewerScreenState();
// }
//
// class _PdfViewerScreenState extends State<PdfViewerScreen> {
//   final String assetPath = "assets/ICC Playing Handbook 2019-20.pdf";
//   late PdfViewerController _pdfViewerController;
//   int _currentPage = 1;
//   List<int> _bookmarks = [];
//
//   // Quiz data structure
//   Map<int, List<Map<String, dynamic>>> quizzes = {
//     1: [
//       {
//         'question': 'What is the primary goal of the ICC Playing Handbook?',
//         'options': [
//           'To entertain cricket fans',
//           'To provide rules and guidelines for cricket matches',
//           'To list cricket records',
//           'To promote cricket merchandise'
//         ],
//         'correctAnswer': 1
//       }
//     ],
//     // Add more quizzes for other pages here
//   };
//
//   @override
//   void initState() {
//     super.initState();
//     _pdfViewerController = PdfViewerController();
//     _loadBookmarks();
//   }
//
//   Future<void> _loadBookmarks() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _bookmarks = prefs.getStringList('bookmarks')?.map(int.parse).toList() ?? [];
//     });
//   }
//
//   Future<void> _saveBookmarks() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('bookmarks', _bookmarks.map((e) => e.toString()).toList());
//   }
//
//   void _toggleBookmark() {
//     setState(() {
//       if (_bookmarks.contains(_currentPage)) {
//         _bookmarks.remove(_currentPage);
//       } else {
//         _bookmarks.add(_currentPage);
//       }
//       _saveBookmarks();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ICC Playing Handbook 2019-20'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.bookmark),
//             onPressed: _toggleBookmark,
//             color: _bookmarks.contains(_currentPage) ? Color(0xffcf2e2e) : null,
//           ),
//           IconButton(
//             icon: Icon(Icons.list),
//             onPressed: _showBookmarks,
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           SfPdfViewer.asset(
//             assetPath,
//             controller: _pdfViewerController,
//             onPageChanged: (PdfPageChangedDetails details) {
//               setState(() {
//                 _currentPage = details.newPageNumber;
//               });
//             },
//           ),
//           Positioned(
//             bottom: 16,
//             right: 16,
//             child: FloatingActionButton(
//               child: Icon(Icons.quiz),
//               onPressed: _showQuiz,
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text('Page $_currentPage'),
//         ),
//       ),
//     );
//   }
//
//   void _showBookmarks() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Bookmarks'),
//         content: SizedBox(
//           width: double.maxFinite,
//           child: ListView.builder(
//             itemCount: _bookmarks.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text('Page ${_bookmarks[index]}'),
//                 onTap: () {
//                   _pdfViewerController.jumpToPage(_bookmarks[index]);
//                   Navigator.pop(context);
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showQuiz() {
//     final pageQuizzes = quizzes[_currentPage];
//     if (pageQuizzes == null || pageQuizzes.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('No Quiz Available'),
//           content: Text('There is no quiz available for this page.'),
//           actions: [
//             TextButton(
//               child: Text('OK'),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ],
//         ),
//       );
//     } else {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => QuizScreen(quizzes: pageQuizzes),
//         ),
//       );
//     }
//   }
// }
//
// class QuizScreen extends StatefulWidget {
//   final List<Map<String, dynamic>> quizzes;
//
//   QuizScreen({required this.quizzes});
//
//   @override
//   _QuizScreenState createState() => _QuizScreenState();
// }
//
// class _QuizScreenState extends State<QuizScreen> {
//   int _currentQuestionIndex = 0;
//   int? _selectedAnswer;
//   bool _answerSubmitted = false;
//
//   void _submitAnswer() {
//     setState(() {
//       _answerSubmitted = true;
//     });
//   }
//
//   void _nextQuestion() {
//     if (_currentQuestionIndex < widget.quizzes.length - 1) {
//       setState(() {
//         _currentQuestionIndex++;
//         _selectedAnswer = null;
//         _answerSubmitted = false;
//       });
//     } else {
//       Navigator.pop(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final currentQuiz = widget.quizzes[_currentQuestionIndex];
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Quiz')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               currentQuiz['question'],
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ...List.generate(
//               currentQuiz['options'].length,
//                   (index) => RadioListTile<int>(
//                 title: Text(currentQuiz['options'][index]),
//                 value: index,
//                 groupValue: _selectedAnswer,
//                 onChanged: _answerSubmitted ? null : (value) {
//                   setState(() {
//                     _selectedAnswer = value;
//                   });
//                 },
//                 tileColor: _answerSubmitted
//                     ? index == currentQuiz['correctAnswer']
//                     ? Colors.green.withOpacity(0.3)
//                     : _selectedAnswer == index
//                     ? Colors.red.withOpacity(0.3)
//                     : null
//                     : null,
//               ),
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 child: Text(_answerSubmitted ? 'Next Question' : 'Submit Answer'),
//                 onPressed: _selectedAnswer == null
//                     ? null
//                     : _answerSubmitted
//                     ? _nextQuestion
//                     : _submitAnswer,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




























// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class PdfViewerScreen extends StatefulWidget {
//   const PdfViewerScreen({Key? key}) : super(key: key);
//
//   @override
//   _PdfViewerScreenState createState() => _PdfViewerScreenState();
// }
//
// class _PdfViewerScreenState extends State<PdfViewerScreen> {
//   final String assetPath = "assets/ICC Playing Handbook 2019-20.pdf";
//   late PdfViewerController _pdfViewerController;
//   late PdfTextSearchResult _searchResult;
//   int _currentPage = 1;
//   List<int> _bookmarks = [];
//   bool _isSearching = false;
//   TextEditingController _searchController = TextEditingController();
//   bool _caseSensitive = false;
//   bool _wholeWord = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _pdfViewerController = PdfViewerController();
//     _searchResult = PdfTextSearchResult();
//     _loadBookmarks();
//   }
//
//   Future<void> _loadBookmarks() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _bookmarks = prefs.getStringList('bookmarks')?.map(int.parse).toList() ?? [];
//     });
//   }
//
//   Future<void> _saveBookmarks() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('bookmarks', _bookmarks.map((e) => e.toString()).toList());
//   }
//
//   void _toggleBookmark() {
//     setState(() {
//       if (_bookmarks.contains(_currentPage)) {
//         _bookmarks.remove(_currentPage);
//       } else {
//         _bookmarks.add(_currentPage);
//       }
//       _saveBookmarks();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ICC Playing Handbook 2019-20'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               setState(() {
//                 _isSearching = !_isSearching;
//                 if (!_isSearching) {
//                   _searchResult.clear();
//                 }
//               });
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.bookmark),
//             onPressed: _toggleBookmark,
//             color: _bookmarks.contains(_currentPage) ? Colors.yellow : null,
//           ),
//           IconButton(
//             icon: Icon(Icons.list),
//             onPressed: _showBookmarks,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           if (_isSearching) _buildSearchBar(),
//           Expanded(
//             child: SfPdfViewer.asset(
//               assetPath,
//               controller: _pdfViewerController,
//               onPageChanged: (PdfPageChangedDetails details) {
//                 setState(() {
//                   _currentPage = details.newPageNumber;
//                 });
//               },
//               canShowScrollHead: false,
//               pageSpacing: 0,
//               pageLayoutMode: PdfPageLayoutMode.single,
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text('Page $_currentPage'),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     hintText: 'Search...',
//                     border: OutlineInputBorder(),
//                   ),
//                   onSubmitted: (value) => _performSearch(),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: _performSearch,
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Checkbox(
//                 value: _caseSensitive,
//                 onChanged: (value) {
//                   setState(() {
//                     _caseSensitive = value!;
//                   });
//                 },
//               ),
//               Text('Case Sensitive'),
//               Checkbox(
//                 value: _wholeWord,
//                 onChanged: (value) {
//                   setState(() {
//                     _wholeWord = value!;
//                   });
//                 },
//               ),
//               Text('Whole Word'),
//             ],
//           ),
//           if (_searchResult.hasResult)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.navigate_before),
//                   onPressed: () {
//                     _searchResult.previousInstance();
//                   },
//                 ),
//                 Text('${_searchResult.currentInstanceIndex + 1} of ${_searchResult.totalInstanceCount}'),
//                 IconButton(
//                   icon: Icon(Icons.navigate_next),
//                   onPressed: () {
//                     _searchResult.nextInstance();
//                   },
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
//
//   void _performSearch() async {
//     _searchResult = await _pdfViewerController.searchText(
//       _searchController.text,
//       // caseSensitive: _caseSensitive,
//       // wholeWords: _wholeWord,
//     );
//     setState(() {});
//     if (_searchResult.totalInstanceCount == 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('No results found')),
//       );
//     }
//   }
//
//   void _showBookmarks() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Bookmarks'),
//         content: SizedBox(
//           width: double.maxFinite,
//           child: ListView.builder(
//             itemCount: _bookmarks.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text('Page ${_bookmarks[index]}'),
//                 onTap: () {
//                   _pdfViewerController.jumpToPage(_bookmarks[index]);
//                   Navigator.pop(context);
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }




































// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
//
// class PdfViewerScreen extends StatefulWidget {
//   final String url;
//
//   const PdfViewerScreen({Key? key, required this.url}) : super(key: key);
//
//   @override
//   _PdfViewerScreenState createState() => _PdfViewerScreenState();
// }
//
// class _PdfViewerScreenState extends State<PdfViewerScreen> {
//   String? localPath;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     loadPDF();
//   }
//
//   Future<void> loadPDF() async {
//     final response = await http.get(Uri.parse(widget.url));
//     final bytes = response.bodyBytes;
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/document.pdf');
//
//     await file.writeAsBytes(bytes, flush: true);
//     setState(() {
//       localPath = file.path;
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : PDFView(
//         filePath: localPath,
//         enableSwipe: true,
//         swipeHorizontal: true,
//         autoSpacing: false,
//         pageFling: false,
//         onRender: (_pages) {
//           setState(() {
//             isLoading = false;
//           });
//         },
//         onError: (error) {
//           print(error.toString());
//         },
//         onPageError: (page, error) {
//           print('$page: ${error.toString()}');
//         },
//         onPageChanged: (int? page, int? total) {
//           print('page change: $page/$total');
//         },
//       ),
//     );
//   }
// }