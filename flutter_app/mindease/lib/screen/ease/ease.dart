import 'package:flutter/material.dart';
import 'package:mindease/screen/ease/meditation.dart';
import 'package:mindease/screen/ease/respirazione.dart';
import 'package:mindease/screen/ease/suoni.dart';
import 'package:mindease/widget/bottom_bar.dart';
import 'package:mindease/widget/click_image.dart';
import 'package:mindease/provider/theme.dart';
import 'package:mindease/widget/top_bar.dart';
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
      home: EasePage(),
    );
  }
}

class EasePage extends ConsumerWidget {
  const EasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(accentColorProvider); // Recupera il colore di sfondo dal provider

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: const Column(
        children: [
          ClickableImage(
            imageUrl: 'assets/images/meditazione.jpg',
            text: 'Pratiche di meditazione',
            height: 150,
            destination: MeditationPage(),
          ),
          ClickableImage(
            imageUrl: 'assets/images/resp.jpg',
            text: 'Esercizi di respirazione',
            destination: RespirationPage(),

          ),
          ClickableImage(
            imageUrl: 'assets/images/suoni.jpeg',
            text: 'Suoni rilassanti',
            height: 100,
            destination: SoundPage(),

          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
