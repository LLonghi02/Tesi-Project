import 'package:flutter/material.dart';
import 'package:mindease/provider/main_support.dart';
import 'package:mindease/provider/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindease/widget/bottom_bar.dart';
import 'package:mindease/widget/top_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindEase',
      home: SupportoPage(),
    );
  }
}

const String defaultBackgroundImage = 'assets/images/supporto.png';

class Message {
  final String text;

  Message(this.text);
}

class SupportoPage extends ConsumerWidget {
  final List<Message> messages = [];

  SupportoPage({Key? key}) : super(key: key);

  void userMessage(String text) {
    if (text.isNotEmpty) {
      messages.add(Message(text));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(accentColorProvider);
    final backgroundImage =
        ref.watch(backgroundImageProvider) ?? defaultBackgroundImage;

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
                      decoration: const InputDecoration(
                        hintText: 'Cosa ti causa ansia?',
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onSubmitted: userMessage,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (messages.isNotEmpty) {
                        userMessage(messages.last.text);
                      } else {
                        // Gestione nel caso in cui non ci siano messaggi
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
                  .map((message) => _buildMessageBubble(message.text))
                  .toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget _buildMessageBubble(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text),
    );
  }
}
