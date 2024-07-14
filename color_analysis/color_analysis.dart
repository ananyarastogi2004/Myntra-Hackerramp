// color_analysis.dart
import 'package:flutter/material.dart';

class SeasonalColor {
  final String hexValue;
  final String season;
  final String characteristics;
  final List<Color> bestColors;
  final List<String> bestColorsNames;
  final String metallics;
  final String metallicsBestSuitability;
  final String metallicsLessSuitability;
  final String metallicsExplanation;
  final String neonColors;
  final String neonLessSuitable;
  final String neonExplanation;

  SeasonalColor({
    required this.hexValue,
    required this.season,
    required this.characteristics,
    required this.bestColors,
    required this.bestColorsNames,
    required this.metallics,
    required this.metallicsBestSuitability,
    required this.metallicsLessSuitability,
    required this.metallicsExplanation,
    required this.neonColors,
    required this.neonLessSuitable,
    required this.neonExplanation,
  });
}

final autumnColors = SeasonalColor(
  hexValue: '#b39486',
  season: 'Autumn',
  characteristics: 'Warm undertones, rich, earthy, and muted colors',
  bestColors: [
    Color(0xFFFFFDD0), // Cream
    Color(0xFFF5F5DC), // Beige
    Color(0xFFC19A6B), // Camel
    Color(0xFF4E3629), // Chocolate Brown
    Color(0xFF8B8680), // Warm Grey
    Color(0xFF8B0000), // Deep Red
    Color(0xFFFF6347), // Tomato Red
    Color(0xFFCC5500), // Burnt Orange
    Color(0xFF8B4513), // Rust
    Color(0xFFE2725B), // Terracotta
    Color(0xFFFF7518), // Pumpkin
    Color(0xFFFFDB58), // Mustard
    Color(0xFFF8DE7E), // Golden Yellow
    Color(0xFF808000), // Moss
    Color(0xFF556B2F), // Olive
    Color(0xFF228B22), // Forest Green
    Color(0xFF568203), // Avocado
    Color(0xFF0095B6), // Warm Blues
    Color(0xFF008080), // Teal
    Color(0xFF40E0D0), // Turquoise
    Color(0xFF000080), // Navy
    Color(0xFF8E4585), // Plum
    Color(0xFF614051), // Aubergine
    Color(0xFFE0B0FF), // Mauve
    Color(0xFFFFD700), // Gold
    Color(0xFFCD7F32), // Bronze
    Color(0xFFB87333), // Copper
  ],
  bestColorsNames: [
    "Cream", "Beige", "Camel", "Chocolate Brown", "Warm Grey",
    "Deep Red", "Tomato Red", "Burnt Orange", "Rust", "Terracotta",
    "Pumpkin", "Mustard", "Golden Yellow", "Moss", "Olive",
    "Forest Green", "Avocado", "Warm Blues", "Teal", "Turquoise",
    "Navy", "Plum", "Aubergine", "Mauve", "Gold", "Bronze", "Copper",
  ],
  metallics: 'Metallics',
  metallicsBestSuitability: 'Best Suitability: Gold, bronze, copper',
  metallicsLessSuitability: 'Less Suitable: Silver, platinum',
  metallicsExplanation: 'These metals complement the warm undertones and add richness to your look. Cooler metals like Silver and Platinum might clash with the warmth of your skin tone.',
  neonColors: 'Neon Colors',
  neonLessSuitable: 'Less Suitable',
  neonExplanation: 'Neon shades are often too bright and can overpower the warm, muted undertones of an Autumn palette. If Needed: Neon coral, neon yellow',
);
