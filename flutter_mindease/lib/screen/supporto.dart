import 'package:flutter/material.dart';
import 'package:flutter_mindease/controller/main_support.dart';
import 'package:flutter_mindease/screen/setting_pages/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/top_bar.dart';

class SupportoPage extends ConsumerWidget {
  const SupportoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(accentColorProvider); // Recupera il colore di sfondo dal provider
    final backgroundImage = ref.watch(backgroundImageProvider); // Recupera l'immagine di sfondo selezionata

    return Scaffold(
      appBar: const TopBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: backcolor, // Colore di sfondo della pagina
            ),
          ),
          if (backgroundImage != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FractionallySizedBox(
                
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ThemeSelectionPage()),
          );
        },
        child: const Icon(Icons.palette),
      ),
    );
  }
}
