import 'package:flutter/material.dart';
import 'package:flutter_application/widget/theme.dart'; // Importa il tuo provider di colore
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barColor = ref.watch(barColorProvider); // Recupera il colore di sfondo dal provider
    final iconColor = ref.watch(detProvider); // Recupera il colore delle icone dal provider

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.spa),
          label: 'Ease',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),  // Icona di Entypo "chat"
          label: 'Supporto',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      selectedItemColor: iconColor, // Imposta il colore delle icone selezionate
      backgroundColor: barColor, //posta il colore di sfondo del BottomNavigationBar
    );
  }
}
