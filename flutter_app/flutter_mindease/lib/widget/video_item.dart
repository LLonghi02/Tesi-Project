import 'package:flutter/material.dart';
import 'package:flutter_mindease/model/video_model.dart';

class VideoListItem extends StatelessWidget {
  final VideoModel video;
  final VoidCallback onTap;

  const VideoListItem({required this.video, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              'https://img.youtube.com/vi/${Uri.parse(video.videoUrl).queryParameters['v']}/0.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              video.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Autore: ${video.author}',
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'video-${video.id}',
                  onPressed: onTap,
                  child: const Icon(Icons.play_arrow),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
