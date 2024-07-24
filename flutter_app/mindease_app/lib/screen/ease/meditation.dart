import 'package:flutter/material.dart';
import 'package:mindease_app/provider/importer.dart';

class MeditationPage extends ConsumerStatefulWidget {
  const MeditationPage({Key? key}) : super(key: key);

  @override
  _MeditationPageState createState() => _MeditationPageState();
}

class _MeditationPageState extends ConsumerState<MeditationPage> {
  VideoModel? selectedVideo;

  @override
  Widget build(BuildContext context) {
    final backcolor = ref.watch(accentColorProvider);
    final AsyncValue<List<VideoModel>> futureVideos = ref.watch(videoProvider('meditazione'));

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: futureVideos.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Errore nel caricamento dei video')),
        data: (videos) {
          if (videos.isEmpty) {
            return const Center(child: Text('Nessun video disponibile'));
          } else {
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return VideoListItem(
                  video: videos[index],
                  isSelected: selectedVideo == videos[index],
                  onTap: () {
                    setState(() {
                      selectedVideo = videos[index];
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
