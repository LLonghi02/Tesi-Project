import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/font.dart';

class ClickableImage extends StatelessWidget {
  final String imageUrl;
  final String text;
  final double? height;
  final double? width; // Optional width parameter

  const ClickableImage({
    super.key,
    required this.imageUrl,
    required this.text,
    this.height, // Optional height parameter
    this.width, // Optional width parameter
  });

  @override
  Widget build(BuildContext context) {
    return Center( // Center the content horizontally
      child: GestureDetector(
        onTap: () {
          // Actions to be executed when the image is pressed
        },
        child: Container(
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white, // Background color for the image opacity
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.5, // Opacity of the image
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: width ?? 340, // Use the passed width or default to 350
                    height: height ?? 200, // Use the passed height or default to 200
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: AppFonts.sign,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
