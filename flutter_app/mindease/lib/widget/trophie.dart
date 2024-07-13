import 'package:flutter/material.dart';
import 'package:mindease/widget/font.dart';

class TrophiesSection extends StatelessWidget {
  final List<bool> objectivesMet;

  TrophiesSection({required this.objectivesMet});

  @override
  Widget build(BuildContext context) {
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
              itemCount: objectivesMet.length,
              itemBuilder: (context, index) {
                // Definizione del testo del trofeo in base all'indice
                String trophyText = '';
                switch (index) {
                  case 0:
                    trophyText = 'Hai aggiornato il calendario 10 volte';
                    break;
                  case 1:
                    trophyText = 'Hai vinto per 5 giorni Mindfulness';
                    break;
                  default:
                    trophyText = 'Trofeo speciale';
                    break;
                }

                // Imposta objectivesMet[index] a false se il trofeo è speciale
                if (trophyText == 'Trofeo speciale') {
                  objectivesMet[index] = false;
                }

                // Calcoliamo l'opacità e il colore di sfondo in base a objectivesMet
                double opacity = objectivesMet[index] ? 1.0 : 0.2;
                Color backgroundColor = objectivesMet[index] ? Colors.white : Colors.grey[400]!;

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
}
