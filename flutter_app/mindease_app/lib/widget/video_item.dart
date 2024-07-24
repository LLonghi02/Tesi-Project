import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:mindease_app/provider/importer.dart';


// Funzione per estrarre l'ID del video da un URL
String? extractVideoIdFromUrl(String url) {
  final RegExp youtubeIdPattern = RegExp(
    r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/|youtube-nocookie\.com\/v\/)([a-zA-Z0-9_-]{11})',
    caseSensitive: false,
    multiLine: false,
  );

  final match = youtubeIdPattern.firstMatch(url);
  final videoId = match?.group(1);

  // Stampa l'ID del video estratto
  print('Extracted video ID: $videoId');

  return videoId;
}

class VideoListItem extends StatefulWidget {
  final VideoModel video;
  final bool isSelected;
  final VoidCallback onTap;

  const VideoListItem({
    Key? key,
    required this.video,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  _VideoListItemState createState() => _VideoListItemState();
}
class _VideoListItemState extends State<VideoListItem> {
  YoutubePlayerController? _controller;
  bool _isPlayerVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.isSelected) {
      _initializeController();
    }
  }

  void _initializeController() {
    final videoId = extractVideoIdFromUrl(widget.video.videoUrl);
    if (videoId != null) {
      setState(() {
        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );
        _isPlayerVisible = true;
      });
    }
  }

  @override
  void didUpdateWidget(covariant VideoListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && _controller == null) {
      _initializeController();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoId = extractVideoIdFromUrl(widget.video.videoUrl);
    final thumbnailUrl = videoId != null
        ? YoutubePlayer.getThumbnail(
            videoId: videoId,
            quality: ThumbnailQuality.high,
          )
        : '';

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              widget.onTap();
              if (!_isPlayerVisible) {
                setState(() {
                  _isPlayerVisible = true;
                });
              }
            },
            child: _isPlayerVisible && _controller != null
                ? Container(
                    height: 200,
                    child: YoutubePlayer(
                      controller: _controller!,
                      showVideoProgressIndicator: true,
                      onReady: () {
                        print('Player is ready');
                      },
                      onEnded: (metadata) {
                        print('Video ended');
                      },
                    ),
                  )
                : Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(thumbnailUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.video.title,
              style: AppFonts.appTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Text(
              'Autore: ${widget.video.author}',
              style: AppFonts.emo,
            ),
          ),
        ],
      ),
    );
  }
}
