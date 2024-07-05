import 'package:flutter/material.dart';
import 'package:flutter_mindease/screen/setting_pages/theme_provider.dart';
import 'package:flutter_mindease/screen/supporto.dart'; // Assicurati di avere la corretta importazione per supporto.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindEase',
      initialRoute: '/',
      routes: {
        '/': (context) => const ChatPage(),
        '/themeSelection': (context) => const ThemeSelectionPage(),
      },
    );
  }
}

final backgroundImageProvider = StateProvider<String?>((ref) => 'assets/images/supporto.png');
