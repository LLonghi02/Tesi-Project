import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mindease/widget/bottom_bar.dart';
import 'package:mindease/widget/top_bar.dart';

class PlaySoundPage extends StatefulWidget {
  final String audioUrl;

  const PlaySoundPage({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _PlaySoundPageState createState() => _PlaySoundPageState();
}
class _PlaySoundPageState extends State<PlaySoundPage> {
  late AudioPlayer _player;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _playAudio(widget.audioUrl);
  }

  Future<void> _playAudio(String audioUrl) async {
    try {
      await _player.setAsset(audioUrl);
      _player.play();
      setState(() {
        _isPlaying = true;
      });
    } catch (error) {
      print('Error playing audio: $error');
    }
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _player.pause();
    } else {
      _player.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/listening.jpg', // Sostituisci con il percorso della tua immagine
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.audioUrl.split('/').last,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  iconSize: 36,
                  onPressed: () {
                    // Logica per traccia precedente
                  },
                ),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  iconSize: 64,
                  onPressed: _togglePlayPause,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  iconSize: 36,
                  onPressed: () {
                    // Logica per traccia successiva
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("10:10"), // Tempo corrente
                Text("15:45"), // Durata totale
              ],
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.5, // Aggiorna questo valore in base alla posizione corrente dell'audio
            ),
          ],
        ),
      ),
            bottomNavigationBar: const BottomBar(),

    );
  }
}