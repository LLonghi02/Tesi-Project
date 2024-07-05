import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/font.dart';

class EmotionButton extends StatelessWidget {
  final String imageUrl;
  final String text;

  const EmotionButton({
    super.key,
    required this.imageUrl,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Actions to be executed when the image is pressed
      },
      borderRadius: BorderRadius.circular(12.0),
      child: Column(
        children: [
          Container(
            width: 60, // Adjusted width to accommodate the image
            height: 60, // Fixed height for the button
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8), // Space between image and text
          Text(
            text,
            style: AppFonts.emo,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
