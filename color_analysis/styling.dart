import 'package:flutter/material.dart';

class BoldHeadingText extends StatelessWidget {
  final String boldText;
  final String normalText;

  const BoldHeadingText({
    super.key,
    required this.boldText,
    required this.normalText,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16, color: Colors.black),
        children: [
          TextSpan(
            text: '$boldText: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: normalText,
          ),
        ],
      ),
    );
  }
}