import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mindease/model/sound_model.dart';
import 'package:just_audio/just_audio.dart'; // Assicurati di importare correttamente il pacchetto just_audio

class AudioPlayerPage extends StatefulWidget {
  final List<SuoniModel> playlist;
  final int initialIndex;

  const AudioPlayerPage({
    Key? key,
    required this.playlist,
    required this.initialIndex,
  }) : super(key: key);

  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}
// Rimuovi l'importazione di 'dart:async'
// Rimuovi anche l'importazione di 'package:just_audio/just_audio'

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  late AudioPlayer _audioPlayer;
  int _currentIndex = 0;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  late StreamSubscription<Duration> _positionSubscription;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _currentIndex = widget.initialIndex;
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _duration = duration ?? Duration.zero;
      });
    });

    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position ?? Duration.zero;
      });
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (state.playing) {
        setState(() {
          _isPlaying = true;
        });
      } else {
        setState(() {
          _isPlaying = false;
        });
      }
    });

    _playAudio(widget.playlist[_currentIndex].videoUrl);
    _isPlaying = true;
  }

  Future<void> _playAudio(String url) async {
    await _audioPlayer.setUrl(url);
    await _audioPlayer.play();
  }

  void _pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  void _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _position = Duration.zero;
    });
  }

  void _playNext() {
    if (_currentIndex < widget.playlist.length - 1) {
      _currentIndex++;
      _playAudio(widget.playlist[_currentIndex].videoUrl);
    } else {
      _currentIndex = 0;
      _playAudio(widget.playlist[_currentIndex].videoUrl);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _positionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/profilo.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              widget.playlist[_currentIndex].title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Slider(
              value: _position.inSeconds.toDouble(),
              min: 0.0,
              max: _duration.inSeconds.toDouble(),
              onChanged: (double value) {
                setState(() {
                  _audioPlayer.seek(Duration(seconds: value.toInt()));
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: _isPlaying ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
                  iconSize: 64,
                  onPressed: () {
                    if (_isPlaying) {
                      _pauseAudio();
                    } else {
                      _playAudio(widget.playlist[_currentIndex].videoUrl);
                    }
                  },
                ),
                const SizedBox(width: 32),
                IconButton(
                  icon: const Icon(Icons.stop),
                  iconSize: 64,
                  onPressed: _stopAudio,
                ),
                const SizedBox(width: 32),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  iconSize: 64,
                  onPressed: _playNext,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
