import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindease/widget/font.dart';
import 'package:mindease/provider/theme.dart';
import 'package:mindease/widget/bottom_bar.dart';
import 'package:mindease/widget/top_bar.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MindEase',
      home: AboutPage(),
    );
  }
}

class AboutPage extends ConsumerWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(detProvider); // Recupera il colore di sfondo dal provider

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Chi siamo:'
              'Benvenuti su MindEase, un\'applicazione mobile dedicata al benessere emotivo e all\'autocura. La nostra missione è aiutare gli utenti a gestire efficacemente ansia e stress attraverso strumenti innovativi e funzionalità di supporto.\n\n'
              'MindEase è più di una semplice app: è un compagno nel tuo percorso verso una migliore salute mentale. Progettata con le esigenze degli utenti al centro, la nostra applicazione offre una serie di funzionalità mirate a promuovere la resilienza emotiva e favorire il relax.\n\n'
              'A MindEase, ci impegniamo nell\'utilizzare la tecnologia per supportare gli individui nel gestire il loro benessere emotivo. Unisciti a noi in questo viaggio verso una vita più equilibrata e sana.\n\n'
              'Scopri MindEase, il tuo partner nel benessere emotivo e nell\'autocura.',
              style: AppFonts.calenda,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
