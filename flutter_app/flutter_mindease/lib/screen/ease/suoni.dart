import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
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
    'assets/sound/Ocean Waves .mp3',
    'assets/sound/Oltre le nuvole (suono rilassante di uccelli).mp3',
    'assets/sound/Piccoli uccellini.mp3',
    'assets/sound/Piccoli volatili.mp3',
    'assets/sound/Relaxing Rain.mp3',
    'assets/sound/River, Thunder & Rain - Calm Excitement.mp3',
    'assets/sound/Soft Sounds of the Night.mp3',
    'assets/sound/Suburban Forest Rain 2.mp3',
    'assets/sound/Suoni degli uccelli.mp3',
    'assets/sound/The Babbling Brook - Scotland.mp3',
    'assets/sound/The Sound Of The Jungle With Coloured Birds For Relaxation, Sleeping, Studying.mp3',
    'assets/sound/Thunderstorm and Rain Music.mp3',
    'assets/sound/Tranquil Babbling Brook for Deep Sleep.mp3',
    'assets/sound/White Noise Rain and River.mp3',
  ];

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _initPlayers();
  }

  Future<void> _initPlayers() async {
    try {
      // Carica e prepara tutti i file audio
      await Future.wait(_audioFiles.map((url) => _player.setAsset(url)));
    } catch (e) {
      print('Error initializing players: $e');
      // Gestisci eventuali errori di inizializzazione qui
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _playAudio(String audioUrl) {
    _player.setAsset(audioUrl).then((_) {
      _player.play();
    }).catchError((error) {
      print('Error playing audio: $error');
    });
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
            title: Text(audioFile.split('/').last), // Mostra solo il nome del file
            onTap: () {
              _playAudio(audioFile);
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
