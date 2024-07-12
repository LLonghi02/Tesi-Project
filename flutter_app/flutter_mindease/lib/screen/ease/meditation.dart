import 'package:flutter/material.dart';
import 'package:flutter_mindease/model/video_model.dart';
import 'package:flutter_mindease/repository/video.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/provider/theme.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:flutter_mindease/widget/video_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MeditationPage extends ConsumerStatefulWidget {
  const MeditationPage({Key? key}) : super(key: key);

  @override
  _MeditationPageState createState() => _MeditationPageState();
}

class _MeditationPageState extends ConsumerState<MeditationPage> {
  YoutubePlayerController? _controller;
  VideoModel? selectedVideo;

  @override
  void initState() {
    super.initState();
    // Initialize YoutubePlayerController when a video is selected
    if (selectedVideo != null) {
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(selectedVideo!.videoUrl)!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    // Dispose the YoutubePlayerController
    _controller?.dispose();
    super.dispose();
  }

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
            return Column(
              children: [
                if (selectedVideo != null)
                  YoutubePlayerBuilder(
                    player: YoutubePlayer(controller: _controller!),
                    builder: (context, player) {
                      return Container(
                        height: 200, // Altezza del container per il video
                        child: player,
                      );
                    },
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      return VideoListItem(
                        video: videos[index],
                        onTap: () {
                          // Update selected video and controller
                          setState(() {
                            selectedVideo = videos[index];
                            _controller?.dispose(); // Dispose the previous controller
                            _controller = YoutubePlayerController(
                              initialVideoId: YoutubePlayer.convertUrlToId(selectedVideo!.videoUrl)!,
                              flags: YoutubePlayerFlags(
                                autoPlay: true,
                                mute: false,
                              ),
                            );
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
