import 'package:flutter/material.dart';
import 'package:myntra/color_analysis.dart';
import 'package:myntra/screens/try_colors.dart';
import 'package:myntra/screens/view_outfits.dart';
import 'package:myntra/styling.dart';

class SeasonalColorAnalysisScreen extends StatelessWidget {
  const SeasonalColorAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seasonal Color Analysis'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Season Determination:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  'Season: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  autumnColors.season,
                  style:const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal
                  ),
                )
              ],
            ),
            BoldHeadingText(
              boldText: 'Characteristics', 
              normalText: autumnColors.characteristics
            ),
            const SizedBox(height: 16),
            const Text(
              'Best Colors',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.6,
              ),
              itemCount: autumnColors.bestColors.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: autumnColors.bestColors[index],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      autumnColors.bestColorsNames[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            const Text(
              'Metallics:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const BoldHeadingText(
              boldText: 'Best Suitability',
              normalText: 'Gold, bronze, copper',
            ),
            const BoldHeadingText(
              boldText: 'Why',
              normalText: 'These metals complement the warm undertones and add richness to your look.',
            ),
            const BoldHeadingText(
              boldText: 'Less Suitable',
              normalText: 'Silver, platinum',
            ),
            const BoldHeadingText(
              boldText: 'Why',
              normalText: 'These cooler metals might clash with the warmth of your skin tone.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Neon Colors:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const BoldHeadingText(
              boldText: 'Suitability',
              normalText: '',
            ),
            const BoldHeadingText(
              boldText: 'Less Suitable',
              normalText: 'Neon pink, green, blue, etc.',
            ),
            const BoldHeadingText(
              boldText: 'Why',
              normalText: 'Neon shades are often too bright and can overpower the warm, muted undertones of an Autumn palette.',
            ),
            const BoldHeadingText(
              boldText: 'If Needed',
              normalText: 'Neon coral, neon yellow',
            ),
            const SizedBox(height: 16),
            const Text(
              'Color Suitability Analysis:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const BoldHeadingText(
              boldText: '1. Warmth',
              normalText: 'Colors with warm undertones complement your skin, creating a harmonious look.',
            ),
            const BoldHeadingText(
              boldText: '2. Depth',
              normalText: 'Medium to dark shades add depth and richness, enhancing your natural warmth.',
            ),
            const BoldHeadingText(
              boldText: '3. Earthiness',
              normalText: 'Earthy tones (muted and natural) are your best friend. They harmonize with the natural depth and warmth of your skin.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Detailed Palette Suggestions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const BoldHeadingText(
              boldText: '1. Tops',
              normalText: 'Olive green blouses, mustard sweaters, terracotta shirts',
            ),
            const BoldHeadingText(
              boldText: '2. Bottoms',
              normalText: 'Camel skirts, chocolate brown trousers, navy pants',
            ),
            const BoldHeadingText(
              boldText: '3. Dresses',
              normalText: 'Rust-colored dresses, plum evening gowns, teal maxi dresses',
            ),
            const BoldHeadingText(
              boldText: '4. Accessories',
              normalText: 'Gold jewelry, bronze scarves, copper belts',
            ),
            const SizedBox(height: 16),
            const Text(
              'Makeup Colors:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const BoldHeadingText(
              boldText: '1. Foundation',
              normalText: 'Warm beige, caramel',
            ),
            const BoldHeadingText(
              boldText: '2. Blush',
              normalText: 'Warm peach, terracotta',
            ),
            const BoldHeadingText(
              boldText: '3. Eyeshadow',
              normalText: 'Warm browns, olive greens, deep plums',
            ),
            const BoldHeadingText(
              boldText: '4. Lipstick',
              normalText: 'Brick red, warm coral, burnt orange',
            ),
            const SizedBox(height: 16),
            const Text(
              'Fabric and Texture Considerations:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const BoldHeadingText(
              boldText: 'Best Fabrics',
              normalText: 'Wool, cotton, linen',
            ),
            const BoldHeadingText(
              boldText: 'Why',
              normalText: 'These fabrics often come in colors that suit the Autumn palette naturally.',
            ),
            const BoldHeadingText(
              boldText: 'Avoid',
              normalText: ' Overly shiny or synthetic materials',
            ),
            const BoldHeadingText(
              boldText: 'Why',
              normalText: ' They might clash with the natural, earthy vibe of the Autumn palette.',
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TryColorsScreen()),
                  );
                },
                child: const Text('Try Colors on Me!'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewOutfitsScreen(bestColors: autumnColors.bestColorsNames),
                    ),
                  );
                },
                child: const Text('View Outfits Curated for You'),
              ),
            )
          ],
        ),
      ),
    );
  }
}