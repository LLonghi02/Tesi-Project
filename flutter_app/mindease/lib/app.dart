import 'package:flutter/material.dart';
import 'package:mindease/screen/google_signin.dart';
import 'package:mindease/screen/mindufulness/mindfulness.dart';
import 'package:mindease/screen/schermata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindease/screen/home_page.dart';
import 'package:mindease/provider/theme.dart';


class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindEase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ref.watch(accentColorProvider),
          brightness: ref.watch(brightnessProvider),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home:   LevelSelectionPage(),
    );
  }
}

