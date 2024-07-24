import 'package:flutter/material.dart';

class EmotionCalenda extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onTap;

  const EmotionCalenda({
    Key? key,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: 50, // Adjusted width to accommodate the image
        height: 50, // Fixed height for the button
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
