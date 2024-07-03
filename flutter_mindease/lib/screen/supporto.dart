import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/top_bar.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MindEase',
      home: SupportoPage(),
    );
  }
}

class SupportoPage extends ConsumerWidget {
  const SupportoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(accentColorProvider); // Recupera il colore di sfondo dal provider

    return Scaffold(
      appBar: const TopBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: backcolor, // Colore di sfondo della pagina
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/supporto.png', // Immagine di sfondo
              fit: BoxFit.cover, // Adatta l'immagine alla dimensione disponibile
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
