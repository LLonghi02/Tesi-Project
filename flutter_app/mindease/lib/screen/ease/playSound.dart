import 'package:mindease/provider/importer.dart';

import 'package:just_audio/just_audio.dart';

final audioPlayerProvider = Provider<AudioPlayer>((ref) => AudioPlayer());

class PlaySoundPage extends ConsumerStatefulWidget {
  String audioUrl;
  int index;
  final List<Map<String, dynamic>> audioFiles; // Lista delle tracce audio

  PlaySoundPage({Key? key, required this.audioUrl, required this.index, required this.audioFiles}) : super(key: key);

  @override
  _PlaySoundPageState createState() => _PlaySoundPageState();
}

class _PlaySoundPageState extends ConsumerState<PlaySoundPage> {
  late AudioPlayer _player;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _player = ref.read(audioPlayerProvider);
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    try {
      await _player.setAsset(widget.audioUrl);
      _player.durationStream.listen((duration) {
        setState(() {
          _duration = duration ?? Duration.zero;
        });
      });
      _player.positionStream.listen((position) {
        setState(() {
          _position = position ?? Duration.zero;
        });
      });
      _player.playerStateStream.listen((playerState) {
        setState(() {
          _isPlaying = playerState.playing;
        });
      });
    } catch (error) {
      print('Error initializing audio player: $error');
    }
  }

  Future<void> _playAudio() async {
    try {
      await _player.play();
      setState(() {
        _isPlaying = true;
      });
    } catch (error) {
      print('Error playing audio: $error');
    }
  }

  void _pauseAudio() {
    _player.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _pauseAudio();
    } else {
      _playAudio();
    }
  }

  void _skipNext() {
    int nextIndex = widget.index + 1;
  
    if (nextIndex < widget.audioFiles.length) {
      String nextAudioUrl = widget.audioFiles[nextIndex]['filePath'];
      
      try {
        _player.pause(); // Pausa l'audio corrente se sta suonando
        _player.setAsset(nextAudioUrl).then((_) {
          _player.play(); // Avvia il nuovo audio
          setState(() {
            widget.index = nextIndex; // Aggiorna l'indice corrente
            widget.audioUrl = nextAudioUrl; // Aggiorna l'URL dell'audio corrente
          });
        });
      } catch (error) {
        print('Error playing next audio: $error');
      }
    } else {
      print('End of playlist'); // Gestire il caso in cui si arriva alla fine della lista
    }
  }

  void _skipPrevious() {
    int prevIndex = widget.index - 1;
  
    if (prevIndex >= 0) {
      String prevAudioUrl = widget.audioFiles[prevIndex]['filePath'];
      
      try {
        _player.pause(); // Pausa l'audio corrente se sta suonando
        _player.setAsset(prevAudioUrl).then((_) {
          _player.play(); // Avvia il nuovo audio
          setState(() {
            widget.index = prevIndex; // Aggiorna l'indice corrente
            widget.audioUrl = prevAudioUrl; // Aggiorna l'URL dell'audio corrente
          });
        });
      } catch (error) {
        print('Error playing previous audio: $error');
      }
    } else {
      print('Beginning of playlist'); // Gestire il caso in cui si arriva all'inizio della lista
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backcolor = ref.watch(accentColorProvider);
    final detcolor = ref.watch(detProvider);

    return Scaffold(
      backgroundColor: backcolor,
      appBar: TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/listening.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.audioUrl.split('/').last.replaceAll('.mp3', ''),
              style: AppFonts.screenTitle,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, color: detcolor),
                  iconSize: 36,
                  onPressed: _skipPrevious,
                ),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: detcolor),
                  iconSize: 64,
                  onPressed: _togglePlayPause,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next, color: detcolor),
                  iconSize: 36,
                  onPressed: _skipNext,
                ),
              ],
            ),
            SizedBox(height: 5),
            LinearProgressIndicator(
              value: (_position.inMilliseconds / _duration.inMilliseconds).clamp(0.0, 1.0),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDuration(_position), style: AppFonts.appTitle), // Current position
                Text(formatDuration(_duration), style: AppFonts.appTitle), // Total duration
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
