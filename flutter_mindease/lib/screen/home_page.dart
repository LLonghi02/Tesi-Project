import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/clik_image.dart';
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
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: backcolor, // Colore di sfondo preso dal provider
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
            // Widget per l'obiettivo quotidiano utilizzando ClickableImage
            ClickableImage(
              imageUrl: 'assets/images/mindfulness.jpg',
              text: 'Il tuo obiettivo quotidiano di Mindfulness',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
