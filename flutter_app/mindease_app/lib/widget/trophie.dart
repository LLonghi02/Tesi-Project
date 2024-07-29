import 'package:flutter/material.dart';
import 'package:mindease_app/provider/importer.dart';

class TrophiesSection extends StatefulWidget {
  final String nickname;

  TrophiesSection({required this.nickname, required List<bool> objectivesMet});

  @override
  _TrophiesSectionState createState() => _TrophiesSectionState();
}

class _TrophiesSectionState extends State<TrophiesSection> {
  late Future<int> resultCountFuture;

  @override
  void initState() {
    super.initState();
    resultCountFuture = fetchResultCount(widget.nickname);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: resultCountFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Errore nel caricamento dei dati'));
        } else if (!snapshot.hasData || snapshot.data == 0) {
          return Center(child: Text('Nessun dato disponibile'));
        } else {
          final int count = snapshot.data!;

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
                    itemCount: 3, // Numero di trofei che abbiamo
                    itemBuilder: (context, index) {
                      // Definizione del testo del trofeo e dello stato di sblocco
                      String trophyText;
                      bool isUnlocked;

                      switch (index) {
                        case 0:
                          trophyText = 'Hai aggiornato il calendario 3 volte';
                          isUnlocked = count >= 3;
                          break;
                        case 1:
                          trophyText = 'Hai aggiornato il calendario 5 volte';
                          isUnlocked = count >= 5;
                          break;
                        case 2:
                          trophyText = 'Hai aggiornato il calendario 10 volte';
                          isUnlocked = count >= 10;
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
                        //margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
