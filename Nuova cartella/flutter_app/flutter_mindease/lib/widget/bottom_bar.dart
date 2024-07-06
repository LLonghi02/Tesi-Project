import 'package:flutter/material.dart';
import 'package:flutter_mindease/screen/ease/ease.dart';
import 'package:flutter_mindease/screen/home_page.dart';
import 'package:flutter_mindease/screen/profile.dart';
import 'package:flutter_mindease/screen/supporto.dart';
import 'package:flutter_mindease/widget/theme.dart'; // Importa il tuo provider di colore
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barColor = ref
        .watch(barColorProvider); // Recupera il colore di sfondo dal provider
    final iconColor =
        ref.watch(detProvider); // Recupera il colore delle icone dal provider

    return Container(
      width: double.infinity, // Imposta la larghezza a tutto lo schermo
      decoration: BoxDecoration(
        color: barColor, // Utilizza il colore di sfondo dal provider
        border: Border(
          top: BorderSide(
            color: iconColor, // Colore del bordo
            width: 2.0, // Larghezza del bordo
          ),
        ),
      ),
      padding: const EdgeInsets.only(
          top: 0.0, bottom: 4.0), // Riduci il padding verticale
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets
                      .zero, // Rimuove il padding interno del pulsante
                  constraints:
                      const BoxConstraints(), // Rimuove i vincoli di dimensione del pulsante
                  icon: Icon(Icons.home,
                      color:
                          iconColor), // Utilizza il colore delle icone dal provider
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  },
                ),
                Text('Home',
                    style: TextStyle(
                        color: iconColor,
                        fontSize: 12)), // Etichetta per l'icona Home
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets
                      .zero, // Rimuove il padding interno del pulsante
                  constraints:
                      const BoxConstraints(), // Rimuove i vincoli di dimensione del pulsante
                  icon: Icon(FontAwesomeIcons.brain,
                      color:
                          iconColor), // Utilizza il colore delle icone dal provider
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const EasePage()),
                    );
                  },
                ),
                Text('Ease',
                    style: TextStyle(
                        color: iconColor,
                        fontSize: 12)), // Etichetta per l'icona Ease
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets
                      .zero, // Rimuove il padding interno del pulsante
                  constraints:
                      const BoxConstraints(), // Rimuove i vincoli di dimensione del pulsante
                  icon: Icon(Icons.chat,
                      color:
                          iconColor), // Utilizza il colore delle icone dal provider
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const SupportoPage()),
                    );
                  },
                ),
                Text('Supporto',
                    style: TextStyle(
                        color: iconColor,
                        fontSize: 12)), // Etichetta per l'icona Chat
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets
                      .zero, // Rimuove il padding interno del pulsante
                  constraints:
                      const BoxConstraints(), // Rimuove i vincoli di dimensione del pulsante
                  icon: Icon(Icons.person,
                      color:
                          iconColor), // Utilizza il colore delle icone dal provider
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => ProfileScreen()),
                    );
                  },
                ),
                Text('Profilo',
                    style: TextStyle(
                        color: iconColor,
                        fontSize: 12)), // Etichetta per l'icona Profile
              ],
            ),
          ),
        ],
      ),
    );
  }
}
