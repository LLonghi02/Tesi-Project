import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindease/provider/main_support.dart';
import 'package:mindease/provider/message.dart';
import 'package:mindease/provider/theme.dart';

import 'package:mindease/widget/bottom_bar.dart';
import 'package:mindease/widget/top_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        title: 'MindEase',
        home: SupportoPage(),
      ),
    );
  }
}

const String defaultBackgroundImage = 'assets/images/supporto.png';

class SupportoPage extends ConsumerWidget {
  const SupportoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(accentColorProvider);
    final backgroundImage = ref.watch(backgroundImageProvider) ?? defaultBackgroundImage;

    final List<Message> messages = ref.watch(messageListProvider);


    void userMessage(String text) {
      if (text.isNotEmpty) {
        ref.read(messageListProvider.notifier).addMessage(Message(text));
      }
    }

    TextEditingController textController = TextEditingController();


    return Scaffold(
      appBar: const TopBar(),
      body: Stack(
        children: [
          // Container for dynamic background color
          Positioned.fill(
            child: Container(
              color: backcolor,
            ),
          ),
          // Background Image
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          // Container for TextField and IconButton
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Cosa ti causa ansia?',
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      textInputAction: TextInputAction.send,
                      // Use TextInputAction.send to enable Enter key to send the message
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      String messageText = textController.text.trim(); // Leggere il testo attuale nel TextField
                      if (messageText.isNotEmpty) {
                        print("Sending message from IconButton: $messageText"); // Controllo per il messaggio dall'IconButton
                        userMessage(messageText);
                        textController.clear(); // Pulire il TextField dopo l'invio del messaggio
                      } else {
                        print("Messaggio vuoto"); 
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          // Messages display
          Positioned(
            left: 16,
            bottom: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: messages
                  .map((message) => _buildMessageBubble(context,message))
                  .toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }


  Widget _buildMessageBubble(BuildContext context, Message message) {
    final isUserMessage = message.isUser;
    final alignment = isUserMessage ? Alignment.centerRight : Alignment.centerLeft;
    final backgroundColor = isUserMessage ? Colors.white : Colors.blueGrey;
    final textColor = isUserMessage ? Colors.black : Colors.white;
    final borderRadius = isUserMessage
        ? const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
          );

    return Align(
      alignment:alignment ,
      child: Container(
        constraints: BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          message.text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }



}
