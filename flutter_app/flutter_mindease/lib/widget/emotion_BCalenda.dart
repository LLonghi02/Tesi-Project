import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/screen/record_emotion.dart';

class EmotionCalenda extends StatelessWidget {
  final String imageUrl;

  const EmotionCalenda({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return InkWell(
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
        ],
      ),
    );
  }
}
