import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/click_image.dart';
import 'package:flutter_mindease/provider/theme.dart';
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
      home: MeditationPage(),
    );
  }
}

class MeditationPage extends ConsumerWidget {
  const MeditationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(accentColorProvider); // Recupera il colore di sfondo dal provider

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: const Column(
        children: [
         
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
