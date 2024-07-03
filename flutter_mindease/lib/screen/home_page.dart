import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/clik_image.dart';
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 170, // Altezza desiderata per l'immagine
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home.jpg'), 
                  fit: BoxFit.cover,
                  alignment: Alignment(0.0, -0.5), // Allinea l'immagine verticalmente in alto
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: backcolor, // Colore di sfondo preso dal provider
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ciao, nome',
                        style: AppFonts.appTitle,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(8.0), // Aggiunto padding per migliorare la visualizzazione
                        child: Text(
                          'Come ti senti oggi?',
                          style: AppFonts.mind,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Widget per l'obiettivo quotidiano utilizzando ClickableImage
                  ClickableImage(
                    imageUrl: 'assets/images/mindfulness.jpg',
                    text: 'Il tuo obiettivo quotidiano di Mindfulness',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
