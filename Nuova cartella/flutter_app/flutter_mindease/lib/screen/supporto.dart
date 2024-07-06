import 'package:flutter/material.dart';
import 'package:flutter_mindease/provider/main_support.dart';
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
    final backcolor = ref.watch(accentColorProvider);
    final backgroundImage = ref.watch(backgroundImageProvider);

    return Scaffold(
      appBar: const TopBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: backcolor,
            ),
          ),
          if (backgroundImage != null) // Verifica se backgroundImage non è null
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
