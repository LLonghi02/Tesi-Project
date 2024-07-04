import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/font.dart';

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
                return Container(
                  width: 130, // Larghezza di ogni card
                  //margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Card(
                    child: Opacity(
                      opacity: objectivesMet[index] ? 1.0 : 0.5,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/images/trofeo.png'),
                            const SizedBox(height: 5),
                            Text(
                              index == 0
                                  ? 'Hai aggiornato il calendario 10 volte'
                                  : 'Hai vinto per 5 giorni Mindfulness',
                              textAlign: TextAlign.center,
                              style: AppFonts.emo,
                            ),
                          ],
                        ),
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
