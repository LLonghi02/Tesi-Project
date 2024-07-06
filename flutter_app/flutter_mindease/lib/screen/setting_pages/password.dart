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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MindEase',
      home: PasswordPage(),
    );
  }
}

final PasswordProvider = StateProvider<String>((ref) => ''); 

class PasswordPage extends ConsumerWidget {
  const PasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(detProvider); // Recupera il colore di sfondo dal provider
    final nickname = ref.watch(PasswordProvider); 

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Modifica la tua password:',
              style: AppFonts.settTitle,
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: nickname,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) {
                ref.read(PasswordProvider.notifier).state = value; 
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Esegui azioni di salvataggio qui
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password salvato con successo!')),
                );
              },
              child: const Text('Salva Password'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}