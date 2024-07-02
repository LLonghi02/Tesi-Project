import 'package:flutter/material.dart';
import 'package:flutter_application/widget/bottom_bar.dart';
import 'package:flutter_application/widget/top_bar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application/widget/theme.dart'; // Assicurati che il percorso sia corretto

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
    final backColor = ref.watch(accentColorProvider);
    backgroundColor: backColor;
    return Scaffold(
      appBar: const TopBar(),
      body: Column(
        children: [
          // Widget superiore
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.lightGreen[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ciao, nome', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Icon(Icons.person, size: 32),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Come ti senti oggi?', style: TextStyle(fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _emotionIcon('FELICE', Icons.sentiment_very_satisfied),
                    _emotionIcon('STRESSATO', Icons.sentiment_dissatisfied),
                    _emotionIcon('IN ANSIA', Icons.sentiment_neutral),
                    _emotionIcon('PREOCCUPATO', Icons.sentiment_very_dissatisfied),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Widget per l'obiettivo quotidiano
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Image.asset('assets/images/mountain.png'), // Assicurati di avere l'immagine nel percorso corretto
                const SizedBox(height: 10),
                const Text(
                  'Il tuo obiettivo quotidiano di Mindfulness',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget _emotionIcon(String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
