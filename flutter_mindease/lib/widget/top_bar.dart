import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBar extends ConsumerWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accentColor = ref.watch(barColorProvider);

    return AppBar(
      backgroundColor: accentColor,
      title: const Row(
        children: [
          CircleAvatar(
            radius: 16, 
            backgroundImage: AssetImage('assets/images/logo.jpg'), // Percorso dell'immagine nel tuo progetto
          ),
          SizedBox(width: 8), // Spazio tra l'immagine e il testo
          Text(
            'MindEase',
            style: AppFonts.appTitle,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
