import 'package:flutter/material.dart';

class EmotionButton extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onPressed;

  const EmotionButton({
    Key? key,
    required this.imageUrl,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Il gestore di onTap viene definito qui
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: 100,
        height: 100,
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
