import 'package:flutter/material.dart';
import 'package:mindease/provider/importer.dart';

class MeditationPage extends ConsumerStatefulWidget {
  const MeditationPage({Key? key}) : super(key: key);

  @override
  _MeditationPageState createState() => _MeditationPageState();
}

class _MeditationPageState extends ConsumerState<MeditationPage> {
  VideoModel? selectedVideo;  // Variabile per tenere traccia del video selezionato

  @override
  Widget build(BuildContext context) {
    final backcolor = ref.watch(accentColorProvider);
    // Ottiene la lista di video di meditazione dal provider, gestito come AsyncValue
    final AsyncValue<List<VideoModel>> futureVideos = ref.watch(videoProvider('meditazione'));

    return Scaffold(
      backgroundColor: backcolor,  
      appBar: const TopBar(),  

      body: futureVideos.when(
        loading: () => const Center(child: CircularProgressIndicator()),  // Mostra un indicatore di caricamento durante il caricamento dei video
        error: (err, stack) => Center(child: Text('Errore nel caricamento dei video')),  // Mostra un messaggio di errore se il caricamento fallisce
        data: (videos) {
          if (videos.isEmpty) {
            return const Center(child: Text('Nessun video disponibile'));  // Mostra un messaggio se non ci sono video
          } else {
            return ListView.builder(
              itemCount: videos.length,  // Numero di elementi nella lista
              itemBuilder: (context, index) {
                return VideoListItem(
                  video: videos[index],  // Passa il video corrente all'item della lista
                  isSelected: selectedVideo == videos[index],  // Indica se l'elemento corrente è selezionato
                  onTap: () {
                    setState(() {
                      selectedVideo = videos[index];  // Aggiorna lo stato con il video selezionato
                    });
                  },
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: const BottomBar(),  
    );
  }
}
