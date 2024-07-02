import 'package:flutter/material.dart';
import 'package:flutter_application/widget/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBar extends ConsumerWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accentColor = ref.watch(barColorProvider);

    return AppBar(
      backgroundColor: accentColor,
      title: Row(
        children: [
          Image.asset(
            'assets/icons/logo.png', // Percorso dell'immagine nel tuo progetto
            width: 24, // Larghezza dell'immagine
            height: 24, // Altezza dell'immagine
          ),
          const SizedBox(width: 8), // Spazio tra l'immagine e il testo
          const Text(
            'MindEase',
            style: TextStyle(
              fontSize: 20, // Dimensione del font
              fontWeight: FontWeight.bold, // Grassetto
              color:  Color(0xFF4FA69E), // Colore del testo
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
