import 'package:mindease/provider/importer.dart';
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
  {'index': 12, 'filePath': 'assets/sound/Ocean Waves .mp3'},
  {'index': 13, 'filePath': 'assets/sound/Oltre le nuvole (suono rilassante di uccelli).mp3'},
  {'index': 14, 'filePath': 'assets/sound/Piccoli uccellini.mp3'},
  {'index': 15, 'filePath': 'assets/sound/Piccoli volatili.mp3'},
  {'index': 16, 'filePath': 'assets/sound/Relaxing Rain.mp3'},
  {'index': 17, 'filePath': 'assets/sound/River, Thunder & Rain - Calm Excitement.mp3'},
  {'index': 18, 'filePath': 'assets/sound/Soft Sounds of the Night.mp3'},
  {'index': 19, 'filePath': 'assets/sound/Suburban Forest Rain 2.mp3'},
  {'index': 20, 'filePath': 'assets/sound/Suoni degli uccelli.mp3'},
  {'index': 21, 'filePath': 'assets/sound/The Babbling Brook - Scotland.mp3'},
  {'index': 22, 'filePath': 'assets/sound/The Sound Of The Jungle With Coloured Birds For Relaxation, Sleeping, Studying.mp3'},
  {'index': 23, 'filePath': 'assets/sound/Thunderstorm and Rain Music.mp3'},
  {'index': 24, 'filePath': 'assets/sound/Tranquil Babbling Brook for Deep Sleep.mp3'},
  {'index': 25, 'filePath': 'assets/sound/White Noise Rain and River.mp3'},
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

