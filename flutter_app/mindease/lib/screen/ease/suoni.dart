import 'package:flutter/material.dart';
import 'package:mindease/widget/bottom_bar.dart';
import 'package:mindease/widget/top_bar.dart';
import 'package:mindease/screen/playSound.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class SoundPage extends StatefulWidget {
  const SoundPage({Key? key}) : super(key: key);

  @override
  _SoundPageState createState() => _SoundPageState();
}

class _SoundPageState extends State<SoundPage> {
  late AudioPlayer _player;
  final List<String> _audioFiles = [
    'assets/sound/Beach Waves.mp3',
    'assets/sound/Beach.mp3',
    'assets/sound/Bosco & Uccelli.mp3',
    'assets/sound/Cinguettio rilassante.mp3',
    'assets/sound/Fire Crackle At the Lake.mp3',
    'assets/sound/Gentle Rivers and Streams.mp3',
    'assets/sound/Hazard\'s Beach.mp3',
    'assets/sound/Mountain Rain.mp3',
    'assets/sound/Musica di rilassamento con uccelli.mp3',
    'assets/sound/Natural Meditation.mp3',
    'assets/sound/Nature Sounds of the Ocean.mp3',
    'assets/sound/Ocean Relax.mp3',
  ];

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _initPlayers();
  }

  Future<void> _initPlayers() async {
    try {
      await Future.wait(_audioFiles.map((url) => _player.setAsset(url)));
    } catch (e) {
      print('Error initializing players: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: ListView.builder(
        itemCount: _audioFiles.length,
        itemBuilder: (context, index) {
          final audioFile = _audioFiles[index];
          return ListTile(
            title: Text(audioFile.split('/').last.replaceAll('.mp3', '')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaySoundPage(audioUrl: audioFile),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Player Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SoundPage(),
    );
  }
}
