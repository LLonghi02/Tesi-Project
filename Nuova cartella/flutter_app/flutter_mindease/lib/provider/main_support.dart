import 'package:flutter/material.dart';
import 'package:flutter_mindease/screen/supporto.dart';
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
      home: SupportoPage(),
    );
  }
}

final backgroundImageProvider = StateProvider<String?>((ref) => null); // Provider per gestire l'immagine di sfondo