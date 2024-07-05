import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:http/http.dart' as http;

final backgroundDetailProvider = StateProvider<Color>((ref) => Colors.blue); // Example provider
final backgroundImageProvider = StateProvider<String?>((ref) => 'assets/images/supporto.png');

class ChatPage extends ConsumerStatefulWidget {
  static const routeName = '/chat';

  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _chatHistory = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final detcolor = ref.watch(backgroundDetailProvider);
    final backgroundImage = ref.watch(backgroundImageProvider);

    return Scaffold(
      backgroundColor: const Color(0xffd2f7ef),
      appBar: const TopBar(),
      body: Stack(
        children: [
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
          Container(
            height: MediaQuery.of(context).size.height - 160,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _chatHistory.length,
                    shrinkWrap: false,
                    controller: _scrollController,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                          left: 14,
                          right: 14,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Align(
                          alignment: _chatHistory[index]["isSender"]
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: _chatHistory[index]["isSender"]
                                  ? const Color(0xFFF69170)
                                  : Colors.white,
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              _chatHistory[index]["message"],
                              style: TextStyle(
                                fontSize: 15,
                                color: _chatHistory[index]["isSender"]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (_isLoading) const CircularProgressIndicator(),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              height: 60,
              width: double.infinity,
              color: const Color(0xffd2f7ef),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: detcolor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8.0),
                          ),
                          controller: _chatController,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  MaterialButton(
                    onPressed: sendMessage,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: detcolor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 88.0,
                          minHeight: 36.0,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  void sendMessage() {
    setState(() {
      if (_chatController.text.isNotEmpty) {
        _chatHistory.add({
          "time": DateTime.now(),
          "message": _chatController.text,
          "isSender": true,
        });
        _chatController.clear();
        _isLoading = true; // Inizia il caricamento quando si invia il messaggio
        _errorMessage = ''; // Resetta il messaggio di errore
      }
    });

    _scrollToBottom();
    getAnswer();
  }

  Future<void> getAnswer() async {
    // Replace with your actual API endpoint
    const url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyCe_CvZwyuvxNhbPtqJ5Bsjj-UXHh5FKr8";
    final uri = Uri.parse(url);

    List<Map<String, String>> msg = [];
    for (var i = 0; i < _chatHistory.length; i++) {
      msg.add({"content": _chatHistory[i]["message"]});
    }

    Map<String, dynamic> request = {
      "prompt": {"messages": msg},
      "temperature": 0.25,
      "candidateCount": 1,
      "topP": 1,
      "topK": 1
    };

    try {
      final response = await http.post(uri, body: jsonEncode(request));

      if (response.statusCode == 200) {
        setState(() {
          _chatHistory.add({
            "time": DateTime.now(),
            "message": json.decode(response.body)["candidates"][0]["content"],
            "isSender": false,
          });
          _isLoading = false; // Stop loading when response is received
        });

        _scrollToBottom();
      } else {
        throw Exception('Failed to load response');
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Stop loading on error
        _errorMessage = 'Error: $e'; // Set error message
      });
      print('Error: $e');
      // Handle error properly (e.g., show error message in UI)
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      }
    });
  }
}
