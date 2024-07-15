//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'recommendation_screen.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String _selectedCategory = 'Top';
  String _selectedSubcategory = 'T-Shirt';
  String _selectedColor = 'Red';
  String _selectedFabric = 'Cotton';
  String _selectedOccasion = 'Casual';
  String _matchWith = 'Jeans';

  final List<String> _categories = [
    'Blazers & WaistCoats',
    'Jackets & Coats',
    'Jeans',
    'Shorts & Skirts',
    'Sweaters & Sweatshirts',
    'Top',
    'Trousers & Capris'
  ];
  final List<String> _subcategories = ['T-Shirt', 'Jeans', 'Skirt', 'Jacket'];
  final List<String> _colors = ['Red', 'Blue', 'Green', 'Black'];
  final List<String> _fabrics = ['Cotton', 'Polyester', 'Leather', 'Denim'];
  final List<String> _occasions = [
    'Casual',
    'Formal',
    'Party',
    'Sports',
    'Outdoor'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Enter Article Details'),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField(
              value: _selectedCategory,
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value as String;
                });
              },
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            DropdownButtonFormField(
              value: _selectedSubcategory,
              items: _subcategories.map((subcategory) {
                return DropdownMenuItem(
                  value: subcategory,
                  child: Text(subcategory),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSubcategory = value as String;
                });
              },
              decoration: const InputDecoration(labelText: 'Subcategory'),
            ),
            DropdownButtonFormField(
              value: _selectedColor,
              items: _colors.map((color) {
                return DropdownMenuItem(
                  value: color,
                  child: Text(color),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedColor = value as String;
                });
              },
              decoration: const InputDecoration(labelText: 'Color'),
            ),
            DropdownButtonFormField(
              value: _selectedFabric,
              items: _fabrics.map((fabric) {
                return DropdownMenuItem(
                  value: fabric,
                  child: Text(fabric),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedFabric = value as String;
                });
              },
              decoration: const InputDecoration(labelText: 'Fabric'),
            ),
            DropdownButtonFormField(
              value: _selectedOccasion,
              items: _occasions.map((occasion) {
                return DropdownMenuItem(
                  value: occasion,
                  child: Text(occasion),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedOccasion = value as String;
                });
              },
              decoration: const InputDecoration(labelText: 'Occasion'),
            ),
            DropdownButtonFormField(
              value: _matchWith,
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _matchWith = value as String;
                });
              },
              decoration: const InputDecoration(labelText: 'Match with'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecommendationScreen(
                      category: _selectedCategory,
                      subcategory: _selectedSubcategory,
                      color: _selectedColor,
                      fabric: _selectedFabric,
                      occasion: _selectedOccasion,
                      matchWith: _matchWith,
                    ),
                  ),
                );
              },
              child: const Text(
                'Show Recommendations',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
