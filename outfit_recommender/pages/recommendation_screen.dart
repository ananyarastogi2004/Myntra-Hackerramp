import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:swipe_cards/swipe_cards.dart';

class RecommendationScreen extends StatefulWidget {
  final String category;
  final String subcategory;
  final String color;
  final String fabric;
  final String occasion;
  final String matchWith;

  RecommendationScreen({
    required this.category,
    required this.subcategory,
    required this.color,
    required this.fabric,
    required this.occasion,
    required this.matchWith,
  });

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  late Database _database;
  List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;

  @override
  void initState() {
    super.initState();
    openDatabaseAndFetchRecommendations();
  }

  Future<void> openDatabaseAndFetchRecommendations() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'products1.db'),
      version: 1,
    );

    await fetchRecommendations();
  }

  Future<void> fetchRecommendations() async {
    final List<Map<String, dynamic>> fetchedRecommendations = await _database
        .rawQuery(
            'SELECT * FROM products1 WHERE category = ? ORDER BY RANDOM ()',
            [widget.matchWith]);

    setState(() {
      _swipeItems = fetchedRecommendations
          .map((product) => SwipeItem(
                content: product,
                /*  likeAction: () {
                  print('Liked product: ${product['name']}');
                },
                nopeAction: () {
                  print('Disliked product: ${product['name']}');
                },
                superlikeAction: () {
                  print('Superliked product: ${product['name']}');
                }, */
              ))
          .toList();

      _matchEngine = MatchEngine(swipeItems: _swipeItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Recommendations'),
        forceMaterialTransparency: true,
      ),
      body: _swipeItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (BuildContext context, int index) {
                final product = _swipeItems[index].content;
                return Card(
                  color: Colors.grey[200],
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          product['img'],
                          height: 400, // Adjust height as needed
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('Color: ${product['colour']}'),
                        Text('Fabric: ${product['fabric']}'),
                        Text('Subcategory: ${product['subcategory']}'),
                        // Add more details as needed
                      ],
                    ),
                  ),
                );
              },
              onStackFinished: () {
                print("Stack Finished");
              },
              upSwipeAllowed: false,
              fillSpace: true,
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () {
          _matchEngine.currentItem?.like();
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }

  @override
  void dispose() {
    _database.close(); // Close the database when screen is disposed
    super.dispose();
  }
}
