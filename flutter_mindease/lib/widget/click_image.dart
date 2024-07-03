import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/font.dart';

class ClickableImage extends StatelessWidget {
  final String imageUrl;
  final String text;

  const ClickableImage({
    Key? key,
    required this.imageUrl,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Azioni da eseguire quando l'immagine è premuta
      },
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white, // Opacità di sfondo per l'immagine
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 0.5, // Opacità dell'immagine
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Positioned.fill(
                // Posizionato per riempire tutto lo stack
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: AppFonts
                          .mind, // Assicurati che AppFonts.mind sia definito correttamente
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
