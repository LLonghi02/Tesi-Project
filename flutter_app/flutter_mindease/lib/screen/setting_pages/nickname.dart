import 'package:flutter/material.dart';
import 'package:flutter_mindease/provider/userProvider.dart';
import 'package:flutter_mindease/repository/mongoDB.dart';
import 'package:flutter_mindease/widget/SignIn/button_1.dart';
import 'package:flutter_mindease/widget/text_field_noIcon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/provider/theme.dart';
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
      home: NicknamePage(),
    );
  }
}

class NicknamePage extends ConsumerWidget {

 const  NicknamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(detProvider); // Recupera il colore di sfondo dal provider
    final TextEditingController oldNicknameController = TextEditingController(); // Controller per il vecchio nickname
    final TextEditingController newNicknameController = TextEditingController(); // Controller per il nuovo nickname

    oldNicknameController.text = ref.watch(nicknameProvider); // Inizializza il controller con il vecchio nickname
    String newNickname="";
                String oldNickname = oldNicknameController.text; // Ottieni il vecchio nickname dal controller

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Modifica il tuo nickname:',
              style: AppFonts.settTitle,
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: oldNicknameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nickname',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) {
                newNickname=value;
                newNicknameController.text = value;
              },
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              onPressed: () async {

                await mongoDBService.open();
                await mongoDBService.updateUserByNickname(oldNickname, newNickname);
                await mongoDBService.close();

                // Aggiorna il vecchio nickname con il nuovo nickname nel provider
                ref.read(nicknameProvider.notifier).state = newNickname;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nickname salvato con successo!')),
                );
              },
              buttonText: 'Salva',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
