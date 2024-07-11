import 'package:flutter/material.dart';
import 'package:flutter_mindease/model/video_model.dart';
import 'package:flutter_mindease/repository/video.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/provider/theme.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:flutter_mindease/widget/video_item.dart';
import 'package:flutter_mindease/widget/video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            return Column(
              children: [
                if (selectedVideo != null)
                  Container(
                    height: 200, // Altezza del container per il video
                    child: VideoPlayerWidget(videoUrl: selectedVideo!.videoUrl),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      return VideoListItem(
                        video: videos[index],
                        onTap: () {
                          setState(() {
                            selectedVideo = videos[index];
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
