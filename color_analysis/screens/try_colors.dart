// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:myntra/color_analysis.dart';


class TryColorsScreen extends StatefulWidget {
  const TryColorsScreen({super.key});

  @override
  _TryColorsScreenState createState() => _TryColorsScreenState();
}

class _TryColorsScreenState extends State<TryColorsScreen> {
  Color selectedColor = autumnColors.bestColors[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Try Colors'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/girl.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      Positioned(
                        top: (MediaQuery.of(context).size.height / 2) + 40,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 125,
                          color: selectedColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    const Text(
                      'Suggested Color Palette',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: autumnColors.bestColors.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = autumnColors.bestColors[index];
                              });
                            },
                            child: Container(
                              width: 60,
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: autumnColors.bestColors[index],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  autumnColors.bestColorsNames[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
