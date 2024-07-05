import 'package:flutter/material.dart';
import 'package:flutter_mindease/model/chat_logic.dart';
import 'package:flutter_mindease/provider/main_support.dart';
import 'package:flutter_mindease/screen/setting_pages/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/top_bar.dart';

class SupportoPage extends ConsumerWidget {
  const SupportoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(accentColorProvider); // Recupera il colore di sfondo dal provider
    final backgroundImage = ref.watch(backgroundImageProvider); // Recupera l'immagine di sfondo selezionata
    final ChatService _chatService = ChatService(); // Initialize chat service

    _chatService.startChat(); // Start the chat
    return Scaffold(
      appBar: const TopBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: backcolor, // Colore di sfondo della pagina
            ),
          ),
          if (backgroundImage != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FractionallySizedBox(
                
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _chatService.handleUserResponse("sto male");
                  },
                  child: const Text("Sto male"),
                ),
                const SizedBox(height: 16),
                StreamBuilder<String>(
                  stream: _chatService.responseStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data!);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ThemeSelectionPage()),
          );
        },
        child: const Icon(Icons.palette),
      ),
    );
  }
}
