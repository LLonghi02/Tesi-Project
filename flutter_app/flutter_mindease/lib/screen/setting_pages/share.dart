import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/top_bar.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MindEase',
      home: SharePage(),
    );
  }
}

class SharePage extends ConsumerWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(detProvider); // Recupera il colore di sfondo dal provider

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Inserisci il tuo nome, cognome e la mail del tuo terapeuta:',
              style: AppFonts.settTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome e cognome',
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email del terapeuta',
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Esegui azioni di salvataggio qui
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Condivisione col terapeuta avvenuta con successo!')),
                );
              },
              child: const Text('Condividi'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
