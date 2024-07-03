import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/click_image.dart';
import 'package:flutter_mindease/widget/emotion_button.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MindEase',
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

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
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
                child: Container(
                  color: backcolor, // Colore di sfondo preso dal provider
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ciao,',
                        style: AppFonts.appTitle,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 130,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Come ti senti oggi?',
                              style: AppFonts.mind,
                            ),
                            SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Row(
                                children: [
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl: 'assets/images/emotion/annoiato.png',
                                    text: 'Annoiato',
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl: 'assets/images/emotion/felice.png',
                                    text: 'Felice',
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl: 'assets/images/emotion/triste.png',
                                    text: 'Triste',
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl: 'assets/images/emotion/ansia.png',
                                    text: 'Ansia',
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl: 'assets/images/emotion/arabbiato.png',
                                    text: 'Arrabbiato',
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl: 'assets/images/emotion/calmo.png',
                                    text: 'Calmo',
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl: 'assets/images/emotion/eccitato.png',
                                    text: 'Eccitato',
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl: 'assets/images/emotion/preoccupato.png',
                                    text: 'Preoccupato',
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl: 'assets/images/emotion/rilassato.png',
                                    text: 'Rilassato',
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl: 'assets/images/emotion/stanco.png',
                                    text: 'Stanco',
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl: 'assets/images/emotion/stressed.png',
                                    text: 'Stressato',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Widget per l'obiettivo quotidiano utilizzando ClickableImage
                      const ClickableImage(
                        imageUrl: 'assets/images/mindfulness.jpg',
                        text: 'Il tuo obiettivo quotidiano di Mindfulness',
                        height: 150,
                        width:550,
                      ),
                    ],
                  ),
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
