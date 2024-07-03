import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_mindease/widget/top_bar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MindEase',
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(accentColorProvider); // Recupera il colore di sfondo dal provider

    return Scaffold(
      appBar: const TopBar(),
      body: Column(
        children: [
          // Widget superiore
          Container(
            padding: const EdgeInsets.all(16.0),
            color: backcolor,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ciao, nome',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.person, size: 32),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Come ti senti oggi?',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
              ],
              
            ),
          ),
          const SizedBox(height: 20),
          // Widget per l'obiettivo quotidiano
          GestureDetector(
            onTap: () {
              // Azioni da eseguire quando l'immagine è premuta
            },
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: 0.5, // Opacità dell'immagine
                      child: Image.asset(
                        'assets/images/mindfulness.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                    const Positioned.fill(
                      // Posizionato per riempire tutto lo stack
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Il tuo obiettivo quotidiano di Mindfulness',
                            style: AppFonts.mind, // Assicurati che AppFonts.mind sia definito correttamente
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
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
