import 'dart:async';

class ChatService {
  int _currentResponseIndex = 0;
  final List<String> _responses = [
    "Da cosa è causata la tua ansia?",
    "Posso aiutarti a capire cosa ti preoccupa?",
    "Come ti senti ora?",
  ];

  StreamController<String> _responseController = StreamController<String>();

  Stream<String> get responseStream => _responseController.stream;

  void startChat() {
    _responseController.add(_responses[_currentResponseIndex]);
  }

  void handleUserResponse(String userResponse) {
    // Here you can add more sophisticated logic based on user input
    _currentResponseIndex = (_currentResponseIndex + 1) % _responses.length;
    _responseController.add(_responses[_currentResponseIndex]);
  }

  void dispose() {
    _responseController.close();
  }
}
