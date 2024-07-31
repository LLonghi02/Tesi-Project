import 'package:flutter/material.dart';
import 'package:mindease/provider/importer.dart';

class RespirationPage extends ConsumerStatefulWidget {
  const RespirationPage({Key? key}) : super(key: key);

  @override
  _RespirationPageState createState() => _RespirationPageState();
}

class _RespirationPageState extends ConsumerState<RespirationPage> {
  VideoModel? selectedVideo;

  @override
  Widget build(BuildContext context) {
    final backcolor = ref.watch(accentColorProvider);
    final AsyncValue<List<VideoModel>> futureVideos = ref.watch(videoProvider('respirazione'));

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
