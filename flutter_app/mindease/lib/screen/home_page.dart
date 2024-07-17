import 'package:flutter/material.dart';
import 'package:mindease/provider/userProvider.dart';
import 'package:mindease/screen/mindufulness/mindfulness.dart';
import 'package:mindease/widget/bottom_bar.dart';
import 'package:mindease/widget/click_image.dart';
import 'package:mindease/widget/emotion_button.dart';
import 'package:mindease/widget/font.dart';
import 'package:mindease/provider/theme.dart';
import 'package:mindease/widget/top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    String name = ref.watch(nicknameProvider);

    return Scaffold(
      backgroundColor: detcolor,
      appBar: const TopBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
                child: Container(
                  color: backcolor,
                  padding: const EdgeInsets.all(16.0),
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
                            SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Row(
                                children: [
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/annoiato.png',
                                    text: 'Annoiato',
                                    nickname: name,
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/felice.png',
                                    text: 'Felice',
                                    nickname: name,
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/triste.png',
                                    text: 'Triste',
                                    nickname: name,
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/ansia.png',
                                    text: 'Ansia',
                                    nickname: name,
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/arabbiato.png',
                                    text: 'Arrabbiato',
                                    nickname: name,
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/calmo.png',
                                    text: 'Calmo',
                                    nickname: name,
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/eccitato.png',
                                    text: 'Eccitato',
                                    nickname: name,
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/preoccupato.png',
                                    text: 'Preoccupato',
                                    nickname: name,
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/rilassato.png',
                                    text: 'Rilassato',
                                    nickname: name,
                                  ),
                                  SizedBox(width: 16),
                                  EmotionButton(
                                    imageUrl:
                                        'assets/images/emotion/stanco.png',
                                    text: 'Stanco',
                                    nickname: name,
                                  ),
                                  SizedBox(width: 16),
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
                        destination: LevelSelectionPage(),
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
