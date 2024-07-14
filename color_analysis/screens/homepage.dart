import 'package:myntra/camera.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seasonal Color Analysis'),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/seasonal_color_analysis.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
                child: const Text(
                  'Click a selfie using front camera by clicking floating button.Ensure proper lighting.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Camera()),
          );
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}
