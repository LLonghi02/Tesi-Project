import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindease/provider/importer.dart';

class ThemeSelectionPage extends ConsumerWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(detProvider); // Recupera il colore di sfondo dal provider

    final themes = [
      {
        'image': 'assets/images/supporto.png',
        'name': 'Maia la maestra di meditazione',
      },
      {
        'image': 'assets/images/mostro.png',
        'name': 'Ansiofido',
      },
      {
        'image': 'assets/images/psicologo.png',
        'name': 'Franco che ascolta',
      },
    ];

    // Funzione per aggiornare e salvare l'immagine di sfondo
    Future<void> _updateBackgroundImage(String newImagePath) async {
      await saveBackgroundImage(newImagePath);
      ref.read(backgroundImageProvider.notifier).state = newImagePath;
    }

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Seleziona il tuo aiutante preferito',
              style: AppFonts.settTitle,
            ),
            const SizedBox(height: 16),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              shrinkWrap: true,
              itemCount: themes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await _updateBackgroundImage(themes[index]['image']!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tema selezionato con successo!'),
                      ),
                    );
                    Navigator.pop(context); // Torna alla pagina precedente
                  },
                  child: Card(
                    elevation: 4.0,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            themes[index]['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            themes[index]['name']!,
                            style: AppFonts.emo,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
