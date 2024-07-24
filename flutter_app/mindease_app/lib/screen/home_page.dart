import 'package:mindease_app/provider/importer.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MindEase',
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(accentColorProvider);
    final detcolor = ref.watch(detProvider);
    final backcolor2 = ref.watch(backgrounDetail);

    String name = ref.watch(nicknameProvider);

    return Scaffold(
      backgroundColor: backcolor2,
      appBar: const TopBar(),
      body: Column(
        children: [
          SizedBox(
            height: 170,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment(0.0, -0.5),
                ),
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              child: Container(
                color: backcolor,
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ciao, $name', // Corretta interpolazione di stringa
                        style: AppFonts.appTitle,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 130,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Come ti senti oggi?',
                              style: AppFonts.mind,
                            ),
                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Row(
                                children: [
                                  const SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/annoiato.png',
                                    text: 'Annoiato',
                                    nickname: name,
                                  ),
                                  const SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/felice.png',
                                    text: 'Felice',
                                    nickname: name,
                                  ),
                                  const SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/triste.png',
                                    text: 'Triste',
                                    nickname: name,
                                  ),
                                  const SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/ansia.png',
                                    text: 'Ansia',
                                    nickname: name,
                                  ),
                                  const SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/arabbiato.png',
                                    text: 'Arrabbiato',
                                    nickname: name,
                                  ),
                                  const SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/calmo.png',
                                    text: 'Calmo',
                                    nickname: name,
                                  ),
                                  const SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/eccitato.png',
                                    text: 'Eccitato',
                                    nickname: name,
                                  ),
                                  const SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/preoccupato.png',
                                    text: 'Preoccupato',
                                    nickname: name,
                                  ),
                                  const SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/rilassato.png',
                                    text: 'Rilassato',
                                    nickname: name,
                                  ),
                                  const SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/stanco.png',
                                    text: 'Stanco',
                                    nickname: name,
                                  ),
                                  const SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/stressed.png',
                                    text: 'Stressato',
                                    nickname: name,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClickableImage(
                        imageUrl: 'assets/images/mindfulness.jpg',
                        text: 'Il tuo obiettivo quotidiano di Mindfulness',
                        height: 150,
                        width: 550,
                        destination:  LevelSelectionPage(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
