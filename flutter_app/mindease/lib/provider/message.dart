import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for storing messages
final messageListProvider =
    StateNotifierProvider<MessageListNotifier, List<Message>>(
        (ref) => MessageListNotifier());

// Message class
class Message {
  final String text;
  final bool
      isUser; // Indicates if the message is from the user or system-generated

  Message(this.text, {this.isUser = true});
}

// Notifier for message list
class MessageListNotifier extends StateNotifier<List<Message>> {
  MessageListNotifier() : super([]);

   void addMessage(Message message) {
    state = [...state, message];
    _generateResponse(message.text); // Chiamare _generateResponse dopo l'aggiunta del messaggio dell'utente
  }

  void _generateResponse(String userMessage) {
    // Dizionario di risposte basate su parole chiave nel messaggio dell'utente
    final responses = {
      "ciao": "Ciao, come stai?",
      "come va?": "Sto bene, grazie! Tu?",
      "aiuto": "Posso aiutarti in qualche modo?",
      "male": "Mi spiace, dimmi di più",
      "ansia":"Resprira e spiegami meglio",
    };

    // Cerca una parola chiave nel messaggio dell'utente
     final responseEntry = responses.entries.firstWhere(
      (entry) => userMessage.toLowerCase().contains(entry.key),
      orElse: () => MapEntry<String, String>("", ""), 
    );

    if (responseEntry.key.isNotEmpty) {
      state = [...state, Message(responseEntry.value, isUser: false)];
    } else {
      _generateRandomResponse();
    }
  }


  void _generateRandomResponse() {
    final randomResponses = [
      "Capisco come ti senti.",
      "Ti capisco e sono qui per te. Non sei solo in questo.",
      "Prenditi il tempo di respirare profondamente. Sarò qui con te.",
      "È normale sentirsi ansiosi, ma ricorda che questa sensazione passerà.",
      "Non c'è nulla di sbagliato nell'avere paura. È un'emozione umana e tutti la proviamo.",
      "Concentrati sul momento presente. Puoi affrontare una cosa alla volta.",
      "Sono orgoglioso/a di te per quanto sei forte e coraggioso/a.",
      "Non giudicarti duramente per i tuoi sentimenti. Sono legittimi e comprensibili.",
      "Ricorda che l'ansia non dura per sempre. Troverai un modo per superarla.",
      "Hai affrontato situazioni difficili in passato e hai superato ogni ostacolo. Anche questa volta ce la farai.",
      "Posso aiutarti in qualche modo? Sono qui per supportarti.",
      "Riconosci i progressi che hai fatto e celebra anche le piccole vittorie.",
      "Insieme possiamo trovare modi per affrontare l'ansia e superarla.",
      "Non devi affrontare questo percorso da solo/a. Ho fiducia nelle tue capacità di superare questa sfida.",
      "Anche quando ti senti debole, ricorda che sei una persona forte.",
      "Le tue emozioni sono valide e meriti di sentirle. Non devi nasconderle o ignorarle.",
      "È normale provare queste sensazioni, ci sono passato anch'io.",
      "Anche quando ti senti debole, ricorda che sei una persona forte."
    ];

    final random = Random();
    final response = randomResponses[random.nextInt(randomResponses.length)];

    state = [...state, Message(response, isUser: false)];
  }
}
