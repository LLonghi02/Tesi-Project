import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindease/provider/theme.dart';
import 'package:mindease/widget/bottom_bar.dart';
import 'package:mindease/widget/top_bar.dart';
import 'package:mindease/screen/playSound.dart';
import 'package:just_audio/just_audio.dart';

final audioPlayerProvider = Provider<AudioPlayer>((ref) => AudioPlayer());

class SoundPage extends ConsumerWidget {
  SoundPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> audioFiles = [
    {'index': 0, 'filePath': 'assets/sound/Beach Waves.mp3'},
    {'index': 1, 'filePath': 'assets/sound/Beach.mp3'},
    {'index': 2, 'filePath': 'assets/sound/Bosco & Uccelli.mp3'},
    {'index': 3, 'filePath': 'assets/sound/Cinguettio rilassante.mp3'},
    {'index': 4, 'filePath': 'assets/sound/Fire Crackle At the Lake.mp3'},
    {'index': 5, 'filePath': 'assets/sound/Gentle Rivers and Streams.mp3'},
    {'index': 6, 'filePath': 'assets/sound/Hazard Beach.mp3'},
    {'index': 7, 'filePath': 'assets/sound/Mountain Rain.mp3'},
    {'index': 8, 'filePath': 'assets/sound/Musica di rilassamento con uccelli.mp3'},
    {'index': 9, 'filePath': 'assets/sound/Natural Meditation.mp3'},
    {'index': 10, 'filePath': 'assets/sound/Nature Sounds of the Ocean.mp3'},
    {'index': 11, 'filePath': 'assets/sound/Ocean Relax.mp3'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(accentColorProvider);
    final detcolor = ref.watch(detProvider);

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: ListView.builder(
        itemCount: audioFiles.length,
        itemBuilder: (context, index) {
          final audioFile = audioFiles[index]['filePath'];
          final audioTitle = audioFile.split('/').last.replaceAll('.mp3', '');

          return Card(
            color: detcolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10.0),
              title: Text(audioTitle, style: const TextStyle(color: Colors.white)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: backcolor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaySoundPage(
                        audioUrl: audioFile,
                        index: index,
                        audioFiles: audioFiles,
                      ),
                    ),
                  );
                },
                child: Icon(Icons.play_arrow, color: detcolor),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Player Demo',
      home: SoundPage(),
    );
  }
}