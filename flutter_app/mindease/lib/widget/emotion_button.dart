import 'package:flutter/material.dart';
import 'package:mindease/widget/font.dart';
import 'package:mindease/screen/record_emotion.dart';

class EmotionButton extends StatelessWidget {
  final String imageUrl;
  final String text;

  const EmotionButton({
    Key? key,
    required this.imageUrl,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RecordEmotionPage(emotion: text),
        ),
      );
    }

    return InkWell(
      onTap: onTap,
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
