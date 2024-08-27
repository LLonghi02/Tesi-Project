import 'package:mindease/provider/importer.dart';
import 'package:just_audio/just_audio.dart';

final audioPlayerProvider = Provider<AudioPlayer>((ref) => AudioPlayer());

class SoundPage extends ConsumerWidget {
  SoundPage({Key? key}) : super(key: key);
final List<Map<String, dynamic>> audioFiles = [
  {'index': 0, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Beach%20Waves.mp3'},
  {'index': 1, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Beach.mp3'},
  {'index': 2, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Bosco%20&%20Uccelli.mp3'},
  {'index': 3, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Cinguettio%20rilassante.mp3'},
  {'index': 4, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Fire%20Crackle%20At%20the%20Lake.mp3'},
  {'index': 5, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Gentle%20Rivers%20and%20Streams.mp3'},
  {'index': 6, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Hazard%20Beach.mp3'},
  {'index': 7, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Mountain%20Rain.mp3'},
  {'index': 8, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Musica%20di%20rilassamento%20con%20uccelli.mp3'},
  {'index': 9, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Natural%20Meditation.mp3'},
  {'index': 10, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Nature%20Sounds%20of%20the%20Ocean.mp3'},
  {'index': 11, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Ocean%20Relax.mp3'},
  {'index': 12, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Ocean%20Waves%20.mp3'},
  {'index': 13, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Oltre%20le%20nuvole%20(suono%20rilassante%20di%20uccelli).mp3'},
  {'index': 14, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Piccoli%20uccellini.mp3'},
  {'index': 15, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Piccoli%20volatili.mp3'},
  {'index': 16, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Relaxing%20Rain.mp3'},
  {'index': 17, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/River,%20Thunder%20&%20Rain%20-%20Calm%20Excitement.mp3'},
  {'index': 18, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Soft%20Sounds%20of%20the%20Night.mp3'},
  {'index': 19, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Suburban%20Forest%20Rain%202.mp3'},
  {'index': 20, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Suoni%20degli%20uccelli.mp3'},
  {'index': 21, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/The%20Babbling%20Brook%20-%20Scotland.mp3'},
  {'index': 22, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/The%20Sound%20Of%20The%20Jungle%20With%20Coloured%20Birds%20For%20Relaxation,%20Sleeping,%20Studying.mp3'},
  {'index': 23, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Thunderstorm%20and%20Rain%20Music.mp3'},
  {'index': 24, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/Tranquil%20Babbling%20Brook%20for%20Deep%20Sleep.mp3'},
  {'index': 25, 'filePath': 'https://raw.githubusercontent.com/LLonghi02/Tesi-Project/main/file/suoni%20rilassanti/White%20Noise%20Rain%20and%20River.mp3'},
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
final audioTitle = audioFile
    .split('/')
    .last
    .replaceAll('.mp3', '')
    .replaceAll('%20', ' ');
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

