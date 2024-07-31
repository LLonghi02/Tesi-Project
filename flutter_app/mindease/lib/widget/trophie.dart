import 'package:flutter/material.dart';
import 'package:mindease/provider/importer.dart';

class TrophiesSection extends StatefulWidget {
  final String nickname;

  TrophiesSection({required this.nickname, required List<bool> objectivesMet});

  @override
  _TrophiesSectionState createState() => _TrophiesSectionState();
}

class _TrophiesSectionState extends State<TrophiesSection> {
  late Future<int> calendarCountFuture;
  late Future<int> mindfulnessCountFuture;

  @override
  void initState() {
    super.initState();
    calendarCountFuture = fetchResultCount(widget.nickname);
    mindfulnessCountFuture = fetchResultCountLevel(widget.nickname);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: Future.wait([calendarCountFuture, mindfulnessCountFuture]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Errore nel caricamento dei dati'));
        } else {
          final int calendarCount = snapshot.data![0];
          final int mindfulnessCount = snapshot.data![1];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'I tuoi obiettivi raggiunti',
                style: AppFonts.appTitle,
              ),
              Center(
                child: Container(
                  height: 130, // Altezza del container per adattarsi alla dimensione dei trofei
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6, // Numero di trofei (3 per ciascun conteggio)
                    itemBuilder: (context, index) {
                      // Definizione del testo del trofeo e dello stato di sblocco
                      String trophyText;
                      bool isUnlocked;

                      switch (index) {
                        case 0:
                          trophyText = 'Hai aggiornato il calendario 5 volte';
                          isUnlocked = calendarCount >= 5;
                          break;
                        case 1:
                          trophyText = 'Hai aggiornato il calendario 10 volte';
                          isUnlocked = calendarCount >= 10;
                          break;
                        case 2:
                          trophyText = 'Hai aggiornato il calendario 30 volte';
                          isUnlocked = calendarCount >= 30;
                          break;
                        case 3:
                          trophyText = 'Hai completato esercizi di mindfulness 5 volte';
                          isUnlocked = mindfulnessCount >= 5;
                          break;
                        case 4:
                          trophyText = 'Hai completato esercizi di mindfulness 10 volte';
                          isUnlocked = mindfulnessCount >= 10;
                          break;
                        case 5:
                          trophyText = 'Hai completato esercizi di mindfulness 30 volte';
                          isUnlocked = mindfulnessCount >= 30;
                          break;
                        default:
                          trophyText = 'Trofeo speciale';
                          isUnlocked = false; // Default a non sbloccato
                          break;
                      }

                      // Calcoliamo l'opacità e il colore di sfondo in base a isUnlocked
                      double opacity = isUnlocked ? 1.0 : 0.2;
                      Color backgroundColor = isUnlocked ? Colors.white : Colors.grey[400]!;

                      return Container(
                        width: 130, // Larghezza di ogni card
                        child: Card(
                          color: backgroundColor,
                          child: Opacity(
                            opacity: opacity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/images/trofeo.png'),
                                const SizedBox(height: 5),
                                Text(
                                  trophyText,
                                  textAlign: TextAlign.center,
                                  style: AppFonts.emo,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}