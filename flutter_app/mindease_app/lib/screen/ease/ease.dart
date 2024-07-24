import 'package:mindease_app/provider/importer.dart';
import 'package:mindease_app/screen/ease/suoni.dart';


class EasePage extends ConsumerWidget {
  const EasePage({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(accentColorProvider); // Recupera il colore di sfondo dal provider

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: Column(
        children: [
          /*ClickableImage(
            imageUrl: 'assets/images/meditazione.jpg',
            text: 'Pratiche di meditazione',
            height: 150,
            destination: MeditationPage(),
          ),*/
          ClickableImage(
            imageUrl: 'assets/images/resp.jpg',
            text: 'Esercizi di respirazione',
            destination: RespirationPage(),
          ),
          ClickableImage(
            imageUrl: 'assets/images/suoni.jpeg',
            text: 'Suoni rilassanti',
            height: 100,
            destination: SoundPage(),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
